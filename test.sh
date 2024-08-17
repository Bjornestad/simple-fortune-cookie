port=$(echo "${{ secrets.KUBECONFIG_TEST }}" > kubeconfig && kubectl --kubeconfig kubeconfig get service frontend -o=jsonpath='{.spec.ports[0].nodePort}')

ip=$( kubectl --kubeconfig kubeconfig get nodes -o=jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')

url="http://$ip:$port/healthz"

# Check if curl was successful and if the response is "healthy"
response=$(curl -s $url | tr -d '\n' | tr -d '\r')

if [ $? -eq 0 ] && [ "$response" = "healthy" ]; then
    echo "This is healthy"
    exit 0
else
    echo "This is not healthy"
    exit 1
fi