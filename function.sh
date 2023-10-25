 #!/bin/bash
welcome()
{
echo -n "Enter Your Name:- "
read Name
echo -n " Welcome Mr. $Name "

echo " $1 and $2 Warm welcome to Pune "
return 10

}

welcome  Vrushali Simran 
return_value=$?
echo -n "Return Value is $return_value"
