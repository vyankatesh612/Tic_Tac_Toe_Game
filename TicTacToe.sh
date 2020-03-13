#!/bin/bash -x
echo "Wel-Come To Tic-Tac-Toe Game ..!"
moves=1
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
			checkuserCell $player $letter
		else
			player="COMPUTER"
			letter="x"
			checkcomputerCell $player $letter  
		fi
	}

function playerturn()
	{
		if [ $player == "USER" ]
		then
			player="COMPUTER"
			letter="x"
			checkcomputerCell $player $letter 
		else
			player="USER"
			letter="o"
			checkuserCell $player $letter 
		fi
	}

function checkuserCell()
	{
		while [[ true ]]
		do
			read -p "choose any position on board " position
			if [[ ${gameboard[$position-1]} -eq $position && ${gameboard[$position-1]} -ne "x" && ${gameboard[$position-1]} -ne "o" ]]
			then
				gameboard[$position-1]=$letter
			else
				echo "Invalid Position ..Choose Another one ..."
				checkuserCell  $letter
			fi

			resetGameboard

			checkwinner $letter

			((moves=$moves+1))

			checkTie $moves
		done

	}

function checkcomputerCell()
	{
		while [[ true ]]
		do
		
			if [[ $(computermoveforRow $letter) == 1 ]]
			then
				resetGameboard
			elif [[ $(computermoveforColumn $letter) == 1 ]]
			then
				resetGameboard
			elif [[ $(computermoveforDiagonal $letter) == 1 ]]
			then
				resetGameboard
			else
				position=$((RANDOM%9 + 1))
				if [[ ${gameboard[$position-1]} -eq $position && ${gameboard[$position-1]} -ne "x" && ${gameboard[$position-1]} -ne "o" ]]
				then
					gameboard[$position-1]=$letter
				else
					checkcomputerCell  $letter
				fi

				resetGameboard
			fi
			checkwinner $letter

			((moves=$moves+1))

			checkTie $moves
		done
	}

function checkTie()
	{
		moves=$1
		if [ $moves -gt 8 ]
		then
			echo "Tie"
			exit
		fi
		playerturn $player
	}

function checkwinner()
	{
		input=$1
		symbol=$input$input$input
		checkRowwin $symbol
		checkColumnwin $symbol
		checkDigonalwin $symbol

	}

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

function computermoveforRow()
	{
		local flag=0
		for ((i=0;i<9;i=$i+3))
		do
			if [[ ${gameboard[$i]} == $1 && ${gameboard[$i+1]} == $1 && ${gameboard[$i+2]} == $((i+3)) ]]
			then
				flag=1
				position=$((i+2))	
				gameboard[$position]=$letter
			elif [[ ${gameboard[$i]} == $1 && ${gameboard[$i+1]} == $((i+2)) && ${gameboard[$i+2]} == $1 ]]
			then
				flag=1
				position=$((i+1))
				gameboard[$position]=$letter
			elif [[ ${gameboard[$i]} == $((i+1)) && ${gameboard[$i+1]} == $1 && ${gameboard[$i+2]} == $1 ]]
			then
				flag=1
				position=$i
				gameboard[$position]=$letter
			else
				flag=0
			fi
		done
		echo  $flag
	}

function computermoveforColumn()
	{
		local flag=0
		for ((i=0;i<3;i++))
		do
			if [[ ${gameboard[$i]} == $1 && ${gameboard[$i+3]} == $1 && ${gameboard[$i+6]} == $((i+7)) ]]
			then
				flag=1
				position=$((i+6))
				gameboard[$position]=$letter
			elif [[ ${gameboard[$i]} == $1 && ${gameboard[$i+3]} == $((i+4)) && ${gameboard[$i+6]} == $1 ]]
			then
				flag=1
				position=$((i+3))
				gameboard[$position]=$letter
			elif [[ ${gameboard[$i]} == $((i+1)) && ${gameboard[$i+3]} == $((i+2)) && ${gameboard[$i+6]} == $1 ]]
			then
				flag=1
				position=$i
				gameboard[$position]=$letter
			else
				flag=0
			fi
		done
		echo $flag
	}

function computermoveforDiagonal()
	{
		if [[ ${gameboard[0]} == $1 && ${gameboard[4]} == $1 && ${gameboard[8]} == 9 ]]
		then
			flag=1
			position=8
			gameboard[$position]=$letter
		elif [[ ${gameboard[0]} == $1 && ${gameboard[4]} == 5 && ${gameboard[8]} == $1 ]]
		then
			flag=1
			position=4
			gameboard[$position]=$letter
		elif [[ ${gameboard[0]} == 1 && ${gameboard[4]} == $1 && ${gameboard[8]} == $1 ]]
		then
			flag=1
			position=0
			gameboard[$position]=$letter
		fi
		echo $flag
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

