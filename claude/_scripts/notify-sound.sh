#!/bin/bash
echo -e '\a'
case "$(uname)" in
  Darwin) afplay /System/Library/Sounds/Hero.aiff & ;;
  Linux)  paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null & ;;
esac
