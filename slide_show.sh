#! /bin/bash

declare -a slides
slides=($@)

nSlides=${#slides[*]}

if [ $nSlides -eq 0 ]; then exit 1; fi

function slideShow ()
{
	local slide=${slides[$1]}

	clear

	head -1 $slide | fmt
	sed 1d $slide
	echo
	echo "slide: [$((idx+1))/$nSlides]"
}

function isNumber()
{
	echo input: $1
	[ "$(echo $1 | grep -v "[^0-9]")" ]
}

menu ()
{

	case $1 in
#       "Enter") ((idx++));;
#       "Up"   ) ((idx++));;
#       "Down" ) ((idx--));;
        "l"    ) idx=$nSlides;;
        "f"    ) idx=0;;
        "Left" ) ((idx--));;
        "Right") ((idx++));;
        *      ) echo nada ;;
	esac

	if (( idx < 0 )); then
		((idx++));
	fi

	if (( idx == nSlides )); then
		((idx--));
	fi

	slideShow $idx
}

function message ()
{
	msg="$*"
	tam_msg=${#msg}
	totcols=$(tput cols)
	col=$(((totcols - tam_msg) / 2))

	# centra msg na linha
	tput cup $linha_msg $col
	tput smso
	echo "$msg"
	tput rmso
}

# -- main --
STRING=

# n=0
# while [ $n -lt ${#STRING} ]
# do
# 	array[$n]=${STRING:n:1}
# 	n=$(( $n + 1 ))
# done

# -- main --

# - tela inicial

clear
message  Bash Slide Show 1.0 -- by Ivan carlos Da Silva Lopes.
STRING='...................................'
#
n=0
while [ $n -lt ${#STRING} ]
do
	echo -n ${STRING:n:1}
	sleep .01 # fast mode
#	sleep .05 # normal mode
	n=$(( $n + 1 ))
done
# ----------------------------------------------------------------------------

first_time=1
oldsettings=$(stty -g)
stty -icanon min 1 time 0 -icrnl -echo
key=""
tput smkx   # set "keypad send mode", needed for cursor keys
while [ "$key" != "q" ]
	do

	if [ $first_time = 1 ];
		then key="Enter"
		first_time=0
	else
		tput smso
		echo -n " < previous  next >"
		tput rmso

		key=$(dd bs=3 count=1 2> /dev/null)
	fi

	if [ "$key" = $(tput cr) ]
		then key="Enter"
	elif [ "$key" = $(tput kcuu1) ]
		then key="Up"
	elif [ "$key" = $(tput kcud1) ]
		then key="Down"
	elif [ "$key" = $(tput kcub1) ]
		then key="Left"
	elif [ "$key" = $(tput kcuf1) ]
		then key="Right"
	fi

	menu $key
done

printf "\nYou hit the \"$key\" key\n"
stty $oldsettings

exit 0
