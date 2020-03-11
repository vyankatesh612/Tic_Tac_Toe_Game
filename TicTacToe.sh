#!/bin/bash -x
echo "Wel-Come To Tic-Tac-Toe Game ..!"
declare -a gameboard
gameboard=(1 2 3 4 5 6 7 8 9)
function resetGameboard()
	{
		echo "--------------"
		for ((i=0;i<9;i=$i+3))
		do
			echo " ${gameboard[$i]}  ""|"" ${gameboard[$i+1]}  ""|"" ${gameboard[$i+2]} "
			echo "--------------"
		done
	}
resetGameboard

function checkToss()
	{
		toss=$((RANDOM%2))
		if [ $toss == 1 ]
		then
			player="player-1"
			letter="o"
		else
			player="player-2"
			letter="x"
		fi
		chooseCell $player $letter
	}
function playerturn()
	{
		if [ $player == "player-1" ]
		then
			player="player-2"
			letter="x"
		else
			player="player-1"
			letter="o"
		fi
		chooseCell $player $letter
	}
function chooseCell()
	{
		num=0
		while [[ $num -lt 10 ]]
		do
			read -p "$player : choose any position on board " position
			for ((i=0;i<9;i++))
			do
				if [[ ${gameboard[$i]} -eq $position ]]
				then
					gameboard[$i]=$letter
				fi
			done
			resetGameboard
			((num=$num+1))

			checkwinner $letter

			if [[ $win == 1 ]]
			then
				echo "$player win"
				break;
			fi
			playerturn $player
		done
	}
function checkwinner()
	{
		input=$1
		symbol=$input$input$input
		arrangement=" "
		#check rows for winning condition
		for ((i=0;i<9;i=$i+3))
      do
      	arrangement=${gameboard[$i]}${gameboard[$i+1]}${gameboard[$i+2]}
			if [ $arrangement == $symbol ]
			then
				win=1
				echo $win
			fi
		done
		#check columns for winning condition
		arrangement=" "
		for ((i=0;i<3;i++))
      do
         arrangement=${gameboard[$i]}${gameboard[$i+3]}${gameboard[$i+6]}
         if [ $arrangement == $symbol ]
         then
            win=1
            echo $win
         fi
      done
		#check diagonal for winning condition
		arrangement=" "
		arrangement=${gameboard[0]}${gameboard[4]}${gameboard[8]}
		if [ $arrangement == $symbol ]
		then 
			win=1
			echo $win
		fi
		arrangement=" "
      arrangement=${gameboard[2]}${gameboard[4]}${gameboard[6]}
      if [ $arrangement == $symbol ]
      then 
         win=1
         echo $win
      fi

	}

checkToss
