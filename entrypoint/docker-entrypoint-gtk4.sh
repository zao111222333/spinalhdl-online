#! /bin/bash
/opt/gtk/bin/gtk4-broadwayd -p 5000&
# gtkwave /opt/gtkwave/AxiRegTC.vcd
i=1
while true
do  
    set_time=1
    echo "TIME $i"
    # /opt/gtkwave/bin/gtkwave.origin &
    /opt/gtk/bin/gtk4-demo &
    sleep $set_time
    PID=$!
    PID_EXIST=$(ps aux | awk '{print $2}'| grep -w $PID)
    if [ ! $PID_EXIST ];then
        echo the process $PID is not exist
        break
    else
        echo the process $PID exist
        kill -9 $PID
    fi
    let i+=1
done
/bin/bash
# gdb /opt/gtkwave/bin/gtkwave.origin core
# coredumpctl gdb $PID
# coredumpctl -o gtkwave.coredump dump /opt/gtkwave/bin/gtkwave.origin