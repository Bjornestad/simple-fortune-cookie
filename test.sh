port=$(run: echo "${{ secrets.KUBECONFIG_TEST }}" > kubeconfig && kubectl --kubeconfig kubeconfig get service | grep frontend | tr -s ' ' | cut -d ' ' -f 5 | cut -c4-10)
echo port is $port
ip=$(run: echo "${{ secrets.KUBECONFIG_TEST }}" > kubeconfig && kubectl --kubeconfig kubeconfig get nodes -o wide | head -n 2 | awk '{print $7}' | sed -n 2p)
echo ip is $ip
if [ $(curl http://$ip$port/healthz) = "healthy" ]; then
    echo "This is healthy"
    exit 0
else
    echo "This is not healthy"
exit 1
fi
