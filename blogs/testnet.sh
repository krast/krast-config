for i in `seq 10000`
 do nohup nc -l $i &
done

for i in `seq 10000`;
 do echo "port."$i; nc -v krast.cn $i;
done
