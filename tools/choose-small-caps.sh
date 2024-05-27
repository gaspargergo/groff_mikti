#!/bin/bash
#This gets a file name as an argument, which is assumed to be a temporary file

#filter temporary reference file for fields which contain author names
names=$(grep -n -e %A -e %E -e %l -e %b $1 | grep -v -e '\\' -)

#set internal field separator to newline, since they separate the database fields
IFS=$'\n'
for line in $names
do
	name=$(echo $line | cut -d " " -f 2-)
	line_number=$(echo $line | cut -d ":" -f 1)
	#needed: check if number, check if valid field number
	echo "Current name: $name"
	read -p "Which name should be in all caps? (default: 1): " choice
	#use one for choice if none selected
	choice="${choice:=1}"
	#choosing the targeted part of the name, without the first letter
	target=$(echo $name | cut -d " " -f $choice | cut -c 2-)
	#uppercasing and wrapping target word in font-size changing groff requests
	sed -i -e "$line_number {s/$target/\\\s-[2.5]\U$target\L\\\s0/}" $1
done
unset IFS

echo "All done!"
