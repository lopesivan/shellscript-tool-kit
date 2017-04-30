#!/bin/bash

#indent_opt="-nbad -bap -nbc -bbo -bl -bli2 -bls -ncdb -nce -cp1 -cs -di2 -ndj -nfc1 -nfca -hnl -i2 -ip5 -lp -pcs -nprs -psl -saf -sai -saw -nsc -nsobA -cdb -sc -bfde"

indent_cansi_opt="-nbad -bap -nbc -bbo -bl -bli2 -bls -ncdb -nce -cp1 -cs -di2 -ndj -nfc1 -nfca -hnl -i2 -ip5 -lp -pcs -nprs -psl -saf -sai -saw -nsc -nsobA -cdb -sc"
astyle_opt="-A4 -s4 --indent=spaces=4 -t4 -b -S -N -Y -L -w -U -F -p -H -j -y -k3 -z2"

file=$1

if [ -f "$file" ]; then
	case "$file" in
	*.c|*.h     )
		cat -s "$file" | indent "$indent_cansi_opt" | astyle "$astyle_opt" > "$file".A
		cp "$file".A "$file"
		rm "$file".A
	;;

	*.cpp|*.hpp )
		bcpp "$file" | cat -s | astyle $astyle_opt > $file.A
		cp "$file".A "$file"
		rm "$file".A
	;;
	*)
		echo "não sei como indentar '$file'..."
	;;
	esac || echo Arquivo $file corrompido

else
	echo "'$file' não é um arquivo válido"
fi

