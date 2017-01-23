awk '{Ip[$3]++;}
END
{ for (var in Ip)
  print var, "access", Ip[var]," times"
}
