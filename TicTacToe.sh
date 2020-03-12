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
			player="USER"
			letter="o"
		else
			player="COMPUTER"
			letter="x"
		fi
		chooseCell $player $letter
	}

function playerturn()
	{
		if [ $player == "USER" ]
		then
			player="COMPUTER"
			letter="x"
		else
			player="USER"
			letter="o"
		fi
			chooseCell $player $letter
	}

num=1
function chooseCell()
	{
		while [[ true ]]
		do
			if [ $player == USER ]
			then
				read -p "choose any position on board " position
			else
				position=$((RANDOM%9 + 1))
        	fi

			if [[ ${gameboard[$position-1]} -eq $position && ${gameboard[$position-1]} -ne "x" && ${gameboard[$position-1]} -ne "o" ]]
			then
				gameboard[$position-1]=$letter
			else
				echo "Invalid Position ..Choose Another one ..."
				chooseCell $player $letter
			fi

			resetGameboard

			checkwinner $letter

			if [ $num -gt 8 ]
      	then
         	echo "Tie"
				exit
      	fi

      	((num=$num+1))

			playerturn $player
		
		done
	}
function checkwinner()
	{
		input=$1
		symbol=$input$input$input
		checkRowwin $symbol
		checkColumnwin $symbol
		checkDigonalwin $symbol

	}
#check rows for winning condition
function checkRowwin()
	{
		arrangement=" "
		for ((i=0;i<9;i=$i+3))
      do
      	arrangement=${gameboard[$i]}${gameboard[$i+1]}${gameboard[$i+2]}
			if [ $arrangement == $symbol ]
			then
				displayWin $player
			fi
		done
	}
#check columns for winning condition
function checkColumnwin()
	{
		arrangement=" "
		for ((i=0;i<3;i++))
      do
         arrangement=${gameboard[$i]}${gameboard[$i+3]}${gameboard[$i+6]}
         if [ $arrangement == $symbol ]
         then
				displayWin $player
         fi
      done
	}
#check diagonal for winning condition
function checkDigonalwin()
	{
		arrangement=" "
		arrangement=${gameboard[0]}${gameboard[4]}${gameboard[8]}
		if [ $arrangement == $symbol ]
		then
			displayWin $player
		fi 
		arrangement=" "
      arrangement=${gameboard[2]}${gameboard[4]}${gameboard[6]}
      if [ $arrangement == $symbol ]
      then
			displayWin $player
      fi
	}
function displayWin()
	{
		if [ $player == USER ]
		then
			echo "Congratulation .. YOU WON...!"
		else
			echo "Sorry..YOU LOST...!"
		fi
		exit
	}

checkToss
