#!/bin/bash

#indent_opt="-nbad -bap -nbc -bbo -bl -bli2 -bls -ncdb -nce -cp1 -cs -di2 -ndj -nfc1 -nfca -hnl -i2 -ip5 -lp -pcs -nprs -psl -saf -sai -saw -nsc -nsobA -cdb -sc -bfde"

  indent_cpp_opt="-bap -bbb -ut -gnu -bap -bbb -br -cs -saf -sai -saw -ut -cbi4 -cli4 -ci4 -sbi4"
indent_cansi_opt="-nbad -bap -nbc -bbo -bl -bli2 -bls -ncdb -nce -cp1 -cs -di2 -ndj -nfc1 -nfca -hnl -i2 -ip5 -lp -pcs -nprs -psl -saf -sai -saw -nsc -nsobA -cdb -sc"
      astyle_opt="-A4 -s4 --indent=spaces=4 -t4 -b -S -N -Y -L -w -U -F -p -H -j -y -k3 -z2"

sed '/./,/^$/!d' -i      $1

case $1 in
	*.c)
		indent $indent_cansi_opt $1
		astyle $astyle_opt       $1

	;;
	*.cpp)
		indent $indent_cpp_opt $1
		astyle $astyle_opt    $1
	;;

esac

exit 0
