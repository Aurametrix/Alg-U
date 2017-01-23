#!/usr/bin/awk -f

#awk '{Ip[$3]++;} END { for (var in Ip) print var, "access", Ip[var]," times"}

#awk '{ip_count[$0]++}; END {for (ip in ip_count) printf "%15s: %d\n",ip,ip_count[ip];}'

BEGIN {
print "IP Address\tAccess Count\tNumber of sites";
}
{
Ip[$3]++;
count[$3]+=$NF;
}
END{
for (var in Ip)
	print var,"\t",Ip[var],"\t\t",count[var];
}
