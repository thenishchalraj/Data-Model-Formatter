#!/bin/bash
# Created by thenishchalraj

# how to run the command ->
# chmod +x ./data_model_formatter.sh
# ./data_model_formatter.sh unformatted_data_model.txt dataModelName exposed

#keep in mind to keep the file_name and the argument in = without any space, otherise it will show 'file_name: command not found'

file_name=$1
new_file_name=$2.kt
expose_value=0

if [[ "$3" == "expose" ]]
	then
		expose_value=1
fi

echo Formatting your file $file_name

echo Everything will be formated into file $new_file_name
touch $new_file_name

while read line
do

	readarray -d : -t each_line <<<$line #split a string based on the delimiter ':'
	each_key=${each_line[0]} #key
	each_value=${each_line[1]//[[:blank:]]/} #value

	echo "@SerializedName(${each_key})" >> $new_file_name
	if [[ expose_value -eq 1 ]]
		then
			echo "@Expose" >> $new_file_name
	fi

	IFS='"'
	read -a each_lines_key <<<${each_key}

	IFS='_'
	read -a each_key_array <<<${each_lines_key[1]}

	printf "var m" >> $new_file_name
	for i in ${each_key_array[@]}; do
		printf ${i^} >> $new_file_name
	done
	printf ": " >> $new_file_name


	if [[ $each_value =~ true ]] || [[ $each_value =~ false ]]; then
		echo "Boolean," >> $new_file_name
	elif [ $each_value > -1 ]; then
		echo "Int," >> $new_file_name
	else echo "String," >> $new_file_name
	fi

	echo >> $new_file_name

done < $file_name
