#!/bin/bash
# Created by thenishchalraj

# how to run the command ->
# chmod +x ./data_model_formatter.sh
# ./data_model_formatter.sh unformatted_data_model.txt dataModelName exposed

#keep in mind to keep the file_name and the argument in = without any space, otherise it will show 'file_name: command not found'

file_name=$1
new_file_name=$2.kt

echo Formatting your file $file_name

echo Everything will be formated into file $new_file_name
touch $new_file_name

while read line
do

	readarray -d : -t each_line <<<$line #split a string based on the delimiter ':'

	IFS='"'
	read -a each_lines_key <<<${each_line[0]}

	IFS='_'
	read -a each_key <<<${each_lines_key[1]}

	printf m >> $new_file_name
	for i in ${each_key[@]}; do
		printf $i >> $new_file_name
	done
	echo >> $new_file_name

done < $file_name
