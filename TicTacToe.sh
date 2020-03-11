#!/bin/bash -x
echo "Wel-Come To Tic-Tac-Toe Game ..!"
declare -a gameboard
gameboard=(1 2 3 4 5 6 7 8 9)
function resetGameboard()
	{
		echo "------------"
		for ((i=0;i<9;i=$i+3))
		do
			echo " ${gameboard[$i]}  ""|""${gameboard[$i+1]}  ""|""${gameboard[$i+2]} "
			echo "------------"
		done
	}
resetGameboard
function checkLetter()
	{
		if [ $((RANDOM%2)) == 1 ]
		then
			letter="X"
		else
			letter="0"
		fi
}
checkLetter
