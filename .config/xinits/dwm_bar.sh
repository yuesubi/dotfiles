#!/bin/bash


function humanReadable {
    local formated=""

    # BYTES
    if [ $1 < '1000' ]; then
        formated="$1B"

    # KILO BYTES
    elif [ $1 < "1000000"]; then
        formated="K"
    
    # MEGA BYTES
    elif [ $1 < "1000000000"]; then
        formated="M"
    
    # GIGA BYTES
    elif [ $1 < "1000000000"]; then
        formated="G"

    # UNEXPECTED RANGE
    else
        formated="NaN"
    fi

    echo "$formated"
}


bar=" test"

cpuload=''
ramusage=''

netdown=''
netup=''

currdate=`date | awk '{ print $1, $3, $2 }'`
currtime='12:00'


#while [ 1 == 1 ]; do

    currtime=`date | awk -F '[[:blank:]:]+' '{ if ($7 == "AM") { printf "%s:%s", $4, $5 } else { printf "%s:%s", $4 + 12, $5 } }'`

    # NET 000B ↓↑ 001K |
    xsetroot -name " CPU  10% | RAM 5.34G/4G | $currdate $currtime "

    sleep 1

#done




PREVTOTAL=0
PREVIDLE=0

while true; do
  CPU=`cat /proc/stat | grep '^cpu '` # Get the total CPU statistics.
  unset CPU[0]                          # Discard the "cpu" prefix.
  IDLE=${CPU[4]}                        # Get the idle CPU time.


# Calculate the total CPU time.
  TOTAL=0
  for VALUE in "${CPU[@]}"; do
    let "TOTAL=$TOTAL+$VALUE"
  done


# Calculate the CPU usage since we last checked.
  let "DIFFIDLE=$IDLE-$PREVIDLE"
  let "DIFFTOTAL=$TOTAL-$PREVTOTAL"
  let "DIFFUSAGE=(1000*($DIFFTOTAL-$DIFFIDLE)/$DIFFTOTAL+5)/10"
  echo -en "\rCPU: $DIFF_USAGE%  \b\b"


# Remember the total and idle CPU times for the next check.
  PREVTOTAL="$TOTAL"
  PREVIDLE="$IDLE"


# Wait before checking again.
  sleep 1
done