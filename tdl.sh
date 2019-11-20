#!/bin/bash
function add_item () {
	read -p "What is the name of the item you want to add ^_^? " name
	read -p "What details do you need to remember about this item " detail

	local -n arr=$1
	local -n arr2=$2
	local -n tdfile=$3
	local -n extra=$4

	arr=("${arr[@]}" "$name")
	arr2=("${arr2[@]}" "$detail")

	for i in "${arr[@]}";
	do
		echo $i
	done >| $tdfile

	for j in "${arr2[@]}";
	do
		echo $j
	done >| $extra	
}

function view_list () {

local -n arr=$1
local -n arr2=$2
local -n arr3=$3
local -n arr4=$4
n=1

for i in "${arr[@]}";
do
	 echo "$n: $i"
	 n=$(($n+1))
done

echo "What would you like to do?"
echo "1-${#arr[@]}) to see more information about a task" 
echo	"A) Mark an item as completed" 
echo 	"B) Add a new item" 
echo	"C) See completed items" 

echo	"Q) Quit" 

read -p "Please enter a choice: " answer

if [ $answer == 'A' ]; then	
	mark_complete $1 $2 $3 $4 $5 $6 $7 $8
elif [ $answer == 'B' ]; then
	add_item $1 $3 $5 $7
elif [ $answer == 'C' ]; then
	view_complete $2 $4
elif [ $answer == 'Q' ]; then
	echo "Goodbye ^_^!"
else
	view_detail $answer $1 $3
fi
}

function view_detail () {
local -n arr=$2
local -n arr2=$3
echo "${arr[$(($1-1))]}:"
echo ${arr2[$(($1-1))]}
}

function mark_complete () {
read -p "Great ^-^! Enter the number of the item would you like to mark as complete? " nitem
local -n arr=$1
local -n arr2=$2
local -n arr3=$3
local -n arr4=$4
local -n out1=$5
local -n out2=$6
local -n out3=$7
local -n out4=$8
w=${arr[$(($nitem-1))]}
v=${arr3[$(($nitem-1))]}

arr2=("${arr2[@]}" "$w")
unset arr[$(($nitem-1))]

arr4=("${arr4[@]}" "$v")
unset arr3[$(($nitem-1))]

for q in "${arr2[@]}";
do
	echo $q
done >| $out2
	
for r in "${arr4[@]}";
do
	echo $r
done >| $out4
	
for s in "${arr[@]}";
do
	echo $s
done >| $out1
	
for t in "${arr3[@]}";
do
	echo $t
done >| $out3
}

function view_complete () {
local -n arr=$1
local -n arr2=$2
k=0
for i in "${arr[@]}";
do
	for j in "${arr2[@]}";
	do
		if [[ "${arr[$k]}" == "$i" && "${arr2[$k]}" == "$j" ]]; 
		then
			echo "$i:"
			echo $j
		fi	
	done
	k=$(($k+1))
done
}

dolist=()
finishlist=()
dlextra=()
flextra=()

input1="/home/pjp1006/dolist.txt"
input2="/home/pjp1006/finishlist.txt"
input3="/home/pjp1006/dlextra.txt"
input4="/home/pjp1006/flextra.txt"
a=""

if [ ! -f "$input1" ]; then
	touch "$input1"
fi

if [ ! -f "$input2" ]; then
	touch "$input2"
fi

if [ ! -f "$input3" ]; then
	touch "$input3";
fi

if [ ! -f "$input4" ]; then
	touch "$input4"
fi

while IFS= read -r line
do
	dolist+=("$line")
done < "$input1"

while IFS= read -r line
do
	finishlist+=("$line")
done < "$input2"

while IFS= read -r line
do
	dlextra+=("$line")
done < "$input3"

while IFS= read -r line
do
	flextra+=("$line")
done < "$input4"

echo "Hello ^_^! Would you like to use the regular or command menu?"
read -p "Type in R for regular and C or command: " menu

if [ $menu == 'R' ]; then
	view_list dolist finishlist dlextra flextra input1 input2 input3 input4
fi

if [ $menu == 'C' ]; then
	read -p "What would you like to do? (if you don't know what command to use type help: " answer
	a=$answer
fi

if [ "$a" == "help" ]; then
		echo "Here is the list of commands ^_^"
		echo "list: list all uncompleted items with numbers."
		echo "complete number: mark an item with the given number as complete."
		echo "list completed: list all the completed items."
		echo "add title: add a new item to the to do list with it's own title and details about the item."
		echo "quit: allow you to quit the to do list program"
fi

if [ "$a" == "list" ]; then
	y=1
	for g in "${dolist[@]}"; do
		echo "$y) $g"
		echo "${dlextra[$(($y-1))]}"
		y=$(($y+1))
	done

elif [ "$a" == "complete number" ]; then
	mark_complete dolist finishlist dlextra flextra input1 input2 input3 input4
elif [ "$a" == "list completed" ]; then
	view_complete finishlist flextra
elif [ "$a" == "add title" ]; then
	add_item dolist dlextra input1 input3
elif [ "$a" == "quit" ]; then
	echo "Goodbye ^_^!"
fi

