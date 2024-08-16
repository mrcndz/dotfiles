function execute
    if test (count $argv) -ne 2
        echo "Use: execute <command> <dir>"
        return 1
    end

    # Obtém o diretório a partir do argumento
    set command $argv[1]
    set dir $argv[2]

    # Verifica se o diretório existe
    if not test -d $dir
        echo "execute: no such directory $dir"
        return 1
    end

    # Executa o comando desejado em cada arquivo do diretório
    for file in $dir/*
        eval $command $file # Substitua 'comando' pelo comando que você deseja usar
    end
end
