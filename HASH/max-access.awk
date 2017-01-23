{
date[$1]++;
}
END{
for (count in date)
{
	if ( max < date[count] ) {
		max = date[count];
		maxdate = count;
	}

}
print "Maximum access is on", maxdate;
}
