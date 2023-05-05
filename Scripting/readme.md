### when user enter y or Y or Yes or yes continue any other key exit
```bash
#!/bin/bash

TO_BE_INSTALLED=y
while [[ "$TO_BE_INSTALLED" == "y" || "$TO_BE_INSTALLED" == "Y" || "$TO_BE_INSTALLED" == "Yes" || "$TO_BE_INSTALLED" == "yes" ]]
do
    # ask the software to be installed
    read -p "Enter the sofware which you want to install: " NAME
    echo "Software to be installed is $NAME"
    read -p "If you want to install more softwares enter y and any other key to exit: " TO_BE_INSTALLED
done
```

### Same loop in for

```bash
#!/bin/bash

# This program will print numbers from 1 to 10
for index in {1..10}
do
    echo $index
done
```

### Same loop in while

```bash
#!/bin/bash
index=1

while [[ $index -le 10 ]]
do
    echo $index
    # increment the value
    index=`expr $index + 1`
    #index=$((index + 1))
done
```

### Same loops with string

```bash
#!bin/bash
SOFTWARES="git tree nano vim"

for SOFTWARE in $SOFTWARES
do
    echo "SOFTWARE to be insttalled is $SOFTWARE"
done
```

### Figuring out if the input is even or odd

```bash
#!/bin/bash
read -p "Enter the number: " NUMBER
REMAINDER=$(($NUMBER % 2))
if [[ $REMAINDER -eq 0 ]]
then
    echo "$NUMBER is even"
else
    echo "$NUMBER is odd"
fi
```
### Comparing Numbers
* Given two integers, X and Y, identify whether X < Y or X > Y or X = Y.
* Exactly one of the following lines:
  - X is less than Y
  - X is greater than Y
  - X is equal to Y

```bash
#!/bin/bash
read X;
read Y;
if [ $X -lt $Y ]
then
    echo "X is less than Y";
elif [ $X -gt $Y ]
then
    echo "X is greater than Y";
else
    echo "X is equal to Y";
fi
```
* Given N integers, compute their average, rounded to three decimal places.

```bash
#!/bin/bash
read t;
sum=0;
for((i=0;i<t;i++))
do
    read num;
    sum=$((sum+num));
done
printf "%.3f" $(echo "scale=4; $sum / $t " | bc )
```

### Looping with Numbers

* Use a for loop to display the natural numbers from 1 to 50.

```bash
#!/bin/bash
for ((i=1;i<=50;i++))
do
    echo "$i";
done
```
or

```bash
#!/bin/bash
for i in {1..50}
do
    echo $i
done
```

### Conditionals

* Given three integers (X, Y, and Z) representing the three sides of a triangle, identify whether the triangle is Scalene, Isosceles, or Equilateral.

* Input Format 
    * Three integers, each on a new line.
* Input Constraints 
    * 1≤X,Y,Z≤1000 
    * Sum of any two sides will be greater than the third.

```bash
#!/bin/bash
read x
read y
read z
if ((($x == $y) && ($y == $z)))
	then
	echo "EQUILATERAL"
elif ((($x == $y) || ($x == $z) || ($y == $z)))
	then
	echo "ISOSCELES"
else
	echo "SCALENE"
fi 
```
### Getting started with conditionals

```bash
#!/bin/bash
read word
if [[($word == 'y') || ($word == 'Y')]]
then
    echo "YES"
        elif [[($word == 'n') || ($word == 'N')]]
        then
        echo "NO"
fi
```

* Read in one character from STDIN.
    * If the character is 'Y' or 'y' display "YES".
    * If the character is 'N' or 'n' display "NO".
    * No other character will be provided as input.
* Input Format
    * One character

```bash
#!/bin/bash
read STDIN
if [[($STDIN == 'y') || ($STDIN == 'Y')]]
then
    echo "YES"
        elif [[($STDIN == 'n') || ($STDIN == 'N')]]
        then
        echo "NO"
fi
```

### Functions and Fractals - Recursive Trees - Bash!

```bash
#!/bin/bash
declare -A a
# d - depth
# l = length
# r = row
# c = column

f() {
    local d=$1 l=$2 r=$3 c=$4
    [[ $d -eq 0 ]] && return
    for ((i=l; i; i--)); do
        a[$((r-i)).$c]=1
    done
    ((r -= l))
    for ((i=l; i; i--)); do
        a[$((r-i)).$((c-i))]=1
        a[$((r-i)).$((c+i))]=1
    done
    f $((d-1)) $((l/2)) $((r-l)) $((c-l))
    f $((d-1)) $((l/2)) $((r-l)) $((c+l))
}
read n
f $n 16 63 49
for ((i=0; i<63; i++)); do
    for ((j=0; j<100; j++)); do
        if [[ ${a[$i.$j]} ]]; then
            printf 1
        else
            printf _
        fi
    done
    echo
done
```