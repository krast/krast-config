function FindProxyForURL(url, host) {
    if (isInNet(host, "127.0.0.1",  "255.0.0.0")){
        return "DIRECT";
    }
    if (isInNet(host, "10.0.0.0",  "255.0.0.0")){
        return "DIRECT";
    }
    if (isInNet(host, "169.224.11.0",  "255.255.255.0"))
    {
        return "DIRECT";
    }
    if (isInNet(host, "192.168.1.0",  "255.255.255.0"))
    {
        return "DIRECT";
    }
    return "SOCKS5 krast.top:25;SOCKS krast.top:25;";
}
