# when user enter y or Y or Yes or yes continue any other key exit

#!/bin/bash

TO_BE_INSTALLED=y
while [[ "$TO_BE_INSTALLED" == "y" || "$TO_BE_INSTALLED" == "Y" || "$TO_BE_INSTALLED" == "Yes" || "$TO_BE_INSTALLED" == "yes" ]]
do
    # ask the software to be installed
    read -p "Enter the sofware which you want to install: " NAME
    echo "Software to be installed is $NAME"
    read -p "If you want to install more softwares enter y and any other key to exit: " TO_BE_INSTALLED
done

### Same loop in for

#!/bin/bash

# This program will print numbers from 1 to 10
for index in {1..10}
do
    echo $index
done

### Same loop in while

#!/bin/bash
index=1

while [[ $index -le 10 ]]
do
    echo $index
    # increment the value
    index=`expr $index + 1`
    #index=$((index + 1))
done

### Same loops with string

SOFTWARES="git tree nano vim"

for SOFTWARE in $SOFTWARES
do
    echo "SOFTWARE to be insttalled is $SOFTWARE"
done

### Figuring out if the input is even or odd

#!/bin/bash
read -p "Enter the number: " NUMBER
REMAINDER=$(($NUMBER % 2))
if [[ $REMAINDER -eq 0 ]]
then
    echo "$NUMBER is even"
else
    echo "$NUMBER is odd"
fi