// global definitions

define($in eth1, $out eth2, $in_addr 172.20.0.2, $in_mac 02:42:ac:14:00:02, $out_addr 172.21.0.2, $out_mac 02:42:ac:15:00:02)

dev_in :: ToDevice($in);
dev_out :: ToDevice($out);

qin :: Queue(200) -> dev_in;
qout :: Queue(200) -> dev_out;

// handle ip

ip :: Strip(14)
      -> CheckIPHeader(INTERFACES $in_addr/255.255.0.0 $out_addr/255.255.0.0)
      -> rt :: StaticIPLookup(
                               $in_addr/32 0,
                               $out_addr/32 0,
                               $in_addr/255.255.0.0 1,
                               $out_addr/255.255.0.0 2);

// Send Arp Query
// arp_q_in :: ARPQuerier($in_addr, $in_mac) -> qin;
// arp_q_out :: ARPQuerier($out_addr, $out_mac) -> qout;

// Send Arp Response
// arpin :: ARPResponder($in_addr $in_mac) -> qin;
// arpout :: ARPResponder($out_addr $out_mac) -> qout;

// ingress traffic on in, switch it to out
FromDevice($in) -> cin :: Classifier(12/0800, 12/0806 20/0001, 12/0806 20/0002, -) -> ip;

// ingress traffic on out, switch it to in
FromDevice($out) -> cout :: Classifier(12/0800, 12/0806 20/0001, 12/0806 20/0002, -) -> ip;

// handle Arp Requests
cin[1] -> Print("Drop arp Req on in") -> Discard;
cout[1] -> Print("Drop arp Req on out") -> Discard;

// handle Arp Response
cin[2] -> Print("Drop arp Resp on in") -> Discard;
cout[2] -> Print("Drop arp Resp on out") -> Discard;

// non ip traffic 
cin[3] -> Print(" in non-ip traffic") -> Discard;
cout[3] -> Print(" out non-ip traffic") -> Discard;

// handle IP Traffic 

// Local delivery
// rt[0] -> IPReassembler -> ping_ipc :: IPClassifier(icmp type echo) -> ICMPPingResponder -> [0]rt;
rt[0] -> Print("Drop Traffic to Self") -> Discard;

// traffic on in
rt[1] -> DropBroadcasts
      -> gin :: IPGWOptions($in_addr)
      -> FixIPSrc($in_addr)
      -> IPPrint(in)
      -> dtin :: DecIPTTL
      -> fragin :: IPFragmenter(1500)
      -> qout;

gin[1] -> ICMPError($in_addr, parameterproblem) -> rt;
dtin[1] -> ICMPError($in_addr, unreachable, needfrag) -> rt;
fragin[1] -> ICMPError($in_addr, unreachable, needfrag) -> rt;


// traffic on out

rt[2] -> DropBroadcasts
      -> gout :: IPGWOptions($out_addr)
      -> FixIPSrc($out_addr)
      -> IPPrint(out)
      -> dtout :: DecIPTTL
      -> fragout :: IPFragmenter(1500)
      -> qin;

gout[1] -> ICMPError($out_addr, parameterproblem) -> rt;
dtout[1] -> ICMPError($out_addr, unreachable, needfrag) -> rt;
fragout[1] -> ICMPError($out_addr, unreachable, needfrag) -> rt;


