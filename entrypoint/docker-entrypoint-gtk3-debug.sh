#! /bin/bash
i=1
while true
do  
    set_time=0.5
    echo "TIME $i"
    # /opt/gtkwave/bin/gtkwave.origin &
    /opt/gtk/bin/broadwayd -p 5000&
    PID1=$!
    sleep $set_time
    gtkwave &
    sleep $set_time
    PID2=$!
    PID_EXIST=$(ps aux | awk '{print $2}'| grep -w $PID2)
    if [ ! $PID_EXIST ];then
        echo the process $PID2 is not exist
        break
    else
        echo the process $PID2 exist
        kill -9 $PID1
        # kill -9 $PID2
    fi
    let i+=1
done
/bin/bash
# gdb /opt/gtkwave/bin/gtkwave.origin core
# coredumpctl gdb $PID
# coredumpctl -o gtkwave.coredump dump /opt/gtkwave/bin/gtkwave.origin