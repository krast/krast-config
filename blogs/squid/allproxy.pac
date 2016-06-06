function FindProxyForURL(url, host) {
        if (isInNet(host, "10.0.0.0",  "255.0.0.0")){
                return "DIRECT";
        }
        if (isInNet(host, "169.224.11.0",  "255.255.255.0"))
        {
                return "DIRECT";
        }
        if (isInNet(host, "192.168.0.0",  "255.255.0.0"))
        {
                return "DIRECT";
        }
    	return "PROXY 47.88.192.58:21";
}
