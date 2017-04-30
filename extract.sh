#!/bin/bash

extract(){
        [ "$1" = "-d" ] && { ECHO=echo; shift; } || ECHO=""
        for file in "$@"
        do
                if [ -f "$file" ]
                then
                        case "$file" in
                                *.tar.bz2|*.tbz2) $ECHO tar xvjf "$file"  ;;
                                *.tar.gz|*.tgz  ) $ECHO tar xvzf "$file"  ;;
                                *.bz2           ) $ECHO bunzip2 "$file"   ;;
                                *.tar.xz        ) $ECHO tar Jxvf "$file"  ;;
                                *.bz2           ) $ECHO bunzip2 "$file"   ;;
                                *.rar           ) $ECHO rar x "$file"     ;;
                                *.gz            ) $ECHO gunzip "$file"    ;;
                                *.tar           ) $ECHO tar xvf "$file"   ;;
                                *.zip           ) $ECHO unzip "$file"     ;;
                                *.Z             ) $ECHO uncompress "$file";;
                                *.7z            ) $ECHO 7z x "$file"      ;;
                                *) echo "não sei como extrair '$file'...";;
                        esac || echo Arquivo $file corrompido

                else
                        echo "'$file' não é um arquivo válido"
                fi
        done
}

extract $*
