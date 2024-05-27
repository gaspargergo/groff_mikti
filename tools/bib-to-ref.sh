#!/bin/bash

database=$1
block=""

#used on non-starting and ultimate fields of the bib file
#extracts content between the curly braces, and appends extracted data to the block variable using the field label given
#args: 1=line 2=field label
cut_field_content() {
	line=$1
	label=$2
	content=$(echo $line | cut -d "{" -f 2 | cut -d "}" -f 1)
	block+="$label $content\n"
}

#this whole thing (especially the middle parts) should be just one sed command, seems much simpler and cleaner
#args: field label
sed_field_content() {
	
}

IFS=$'\n'
for line in $(cat $database)
do
	if [[ $(echo $line | grep @) ]] 
	then 
		keyword=$(echo $line | cut -d "{" -f 2 | rev | cut -c 2- | rev)
		block+="%K $keyword\n"

	#INNER BLOCKS
	elif [[ $(echo $line | grep title) ]]; then cut_field_content $line "%T"
	elif [[ $(echo $line | grep publisher) ]]; then cut_field_content $line "%I"
	elif [[ $(echo $line | grep address) ]]; then cut_field_content $line "%C"
	elif [[ $(echo $line | grep year) ]]; then cut_field_content $line "%D"
	elif [[ $(echo $line | grep pages) ]]; then cut_field_content $line "%P"
	elif [[ $(echo $line | grep series) ]]; then cut_field_content $line "%S"
	elif [[ $(echo $line | grep volume) ]]; then cut_field_content $line "%V"
	elif [[ $(echo $line | grep number) ]]; then cut_field_content $line "%N"
	elif [[ $(echo $line | grep journal) ]]; then cut_field_content $line "%J"
	elif [[ $(echo $line | grep url) ]]; then cut_field_content $line "%u"
	elif [[ $(echo $line | grep urldate) ]]; then cut_field_content $line "%a"
	elif [[ $(echo $line | grep website) ]]; then cut_field_content $line "%s" #this is not a very common bib entry, I made it up
	#possibly more than one name, since bib puts them all in one entry
	elif [[ $(echo $line | grep author) ]]; then cut_field_content $line "%A"
	elif [[ $(echo $line | grep translator) ]]; then cut_field_content $line "%l"
	elif [[ $(echo $line | grep editor) ]]; then cut_field_content $line "%E"
	#more work needed, since bib does not have an enty field for a book author
	elif [[ $(echo $line | grep booktitle) ]]; then cut_field_content $line "%B"

	#final line of reference block
	elif [[ $(echo $line | grep "^}") ]]
	then 
		newfile+="$block\n"
		block=""
	else echo "Unknown line: $line"
	fi
done
echo -e $newfile
unset IFS

