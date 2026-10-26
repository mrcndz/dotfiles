import AppKit
import CoreGraphics
import Foundation

// Private SkyLight call (same one LightsOut/BetterDisplay use); resolved at runtime so a
// macOS update that drops it fails cleanly instead of crashing at launch.
typealias ConfigureDisplayEnabled = @convention(c) (CGDisplayConfigRef, CGDirectDisplayID, Bool) -> Int32

let configureDisplayEnabled: ConfigureDisplayEnabled? = {
    let handle = dlopen(nil, RTLD_NOW)
    for symbol in ["SLSConfigureDisplayEnabled", "CGSConfigureDisplayEnabled"] {
        if let ptr = dlsym(handle, symbol) {
            return unsafeBitCast(ptr, to: ConfigureDisplayEnabled.self)
        }
    }
    return nil
}()

// Disabled displays drop out of the online list, so remember their IDs to turn them back on.
let stateFile = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".local/state/displayctl/disabled")

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data("displayctl: \(message)\n".utf8))
    exit(1)
}

func readDisabled() -> [CGDirectDisplayID] {
    guard let text = try? String(contentsOf: stateFile, encoding: .utf8) else { return [] }
    return text.split(separator: "\n").compactMap { CGDirectDisplayID($0) }
}

func writeDisabled(_ ids: [CGDirectDisplayID]) {
    try? FileManager.default.createDirectory(
        at: stateFile.deletingLastPathComponent(), withIntermediateDirectories: true)
    try? ids.map(String.init).joined(separator: "\n").write(to: stateFile, atomically: true, encoding: .utf8)
}

func onlineDisplays() -> [(id: CGDirectDisplayID, name: String)] {
    var ids = [CGDirectDisplayID](repeating: 0, count: 16)
    var count: UInt32 = 0
    CGGetOnlineDisplayList(UInt32(ids.count), &ids, &count)
    let names = Dictionary(
        NSScreen.screens.compactMap { screen -> (CGDirectDisplayID, String)? in
            guard let id = screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? CGDirectDisplayID
            else { return nil }
            return (id, screen.localizedName)
        },
        uniquingKeysWith: { first, _ in first })
    return ids.prefix(Int(count)).map { ($0, names[$0] ?? "Display \($0)") }
}

func setEnabled(_ id: CGDirectDisplayID, _ enabled: Bool) {
    guard let configure = configureDisplayEnabled else { fail("display enable API not available on this macOS") }
    var config: CGDisplayConfigRef?
    guard CGBeginDisplayConfiguration(&config) == .success, let config else { fail("cannot begin display configuration") }
    guard configure(config, id, enabled) == 0 else {
        CGCancelDisplayConfiguration(config)
        fail("cannot \(enabled ? "enable" : "disable") display \(id)")
    }
    guard CGCompleteDisplayConfiguration(config, .forSession) == .success else { fail("cannot apply display configuration") }
}

func disable(matching query: String) {
    let matches = onlineDisplays().filter {
        $0.name.localizedCaseInsensitiveContains(query) && CGDisplayIsBuiltin($0.id) == 0
    }
    guard !matches.isEmpty else { fail("no online external display matches '\(query)'") }
    var disabled = readDisabled()
    for display in matches {
        setEnabled(display.id, false)
        if !disabled.contains(display.id) { disabled.append(display.id) }
        print("off \(display.id) \(display.name)")
    }
    writeDisabled(disabled)
}

func enableAll() {
    for id in readDisabled() {
        setEnabled(id, true)
        print("on \(id)")
    }
    writeDisabled([])
}

let args = CommandLine.arguments.dropFirst()
switch (args.first, args.dropFirst().first) {
case ("list", nil):
    for display in onlineDisplays() {
        print("\(display.id)\t\(CGDisplayIsBuiltin(display.id) != 0 ? "built-in" : "external")\t\(display.name)")
    }
    for id in readDisabled() { print("\(id)\tdisabled") }
case ("off", let query?):
    disable(matching: query)
case ("on", nil):
    enableAll()
default:
    fail("usage: displayctl list | off <name> | on")
}
