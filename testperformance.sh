function memory_util ()
{
  BUFFCACHE_MEM=$(free -m | awk '/Mem/ {print $6}')
  FREE_MEM=$(free -m | awk '/Mem/ {print $4}')
  YIELD_MEM=$(( $BUFFCACHE_MEM + $FREE_MEM ))
  
  AVAILABLE_MEM=$(free -m | awk '/Mem/ {print $7}')
  TOTAL_MEM=$(free -m | awk '/Mem/ {print $2}')

  TOTAL_USED_MEM=$(( $TOTAL_MEM - $AVAILABLE_MEM ))

  #Total memory usage is Total Memory - Available Memory
  MEM_USAGE_PERCENT=$(bc <<<"scale=2; $TOTAL_USED_MEM * 100 / $TOTAL_MEM")

  echo -e "........................................\nMEMORY UTILIZATION\n"
  echo -e "Total Memory\t\t:$TOTAL_MEM MB"
  echo -e "Available Memory\t:$AVAILABLE_MEM MB"
  echo -e "Buffer+Cache Memory\t:$BUFFCACHE_MEM MB"
  echo -e "Free Memory\t\t:$FREE_MEM MB"
  echo -e "Memory Usage Percentage\t:$MEM_USAGE_PERCENT %"

  #if available or (free+buffer+cache) is close to 0
  #We will warn the user if it's below 100 MiB
  if [ $AVAILABLE_MEM -lt 100 -o $YIELD_MEM -lt 100 ] ; then
    echo "Available Memory or the free and buffer+cache Memory is too low!"
    echo "Unhealthy Memory!"
  #if kernel employed OOM Killer process
  elif dmesg | grep oom-killer > /dev/null ; then
    echo "System is critically low on memory!"
  else
    echo -e "\nMEMORY OK\n........................................"
  fi
}
memory_util
