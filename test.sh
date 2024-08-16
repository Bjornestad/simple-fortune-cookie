port=$(kubectl get service | grep frontend | tr -s ' ' | cut -d ' ' -f 5 | cut -c5-10)
echo port is $port
ip=$(kubectl get nodes -o wide | head -n 2 | awk '{print $7}' | sed -n 2p)
echo ip is $ip
if [ $(curl $port$ip/healthz) = "healthy" ]; then
    exit 1
fi
exit 0