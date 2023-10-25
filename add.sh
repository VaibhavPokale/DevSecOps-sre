#!/bin/bash
A=100
B=200
while [ $A -lt  $B ]
do
	echo $A
	A=`expr $A + 10`
done
