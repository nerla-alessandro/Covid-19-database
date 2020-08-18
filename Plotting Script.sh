#!/bin/bash

shownCountries=10;

queryResult=$(mktemp ./query-result.XXX);

countries=$(mktemp ./countries.XXX);

countryFiles=();

i=0;

sqlite3 coronavirus.db "SELECT geoId, SUM(cases) AS \"Total\" FROM CaseData GROUP BY geoId ORDER BY Total DESC LIMIT $shownCountries" > $countries;

sqlite3 coronavirus.db "SELECT T1.dateFormatted AS Date, T1.geoId AS Country, SUM(T3.deaths) AS \"Cumulative Deaths\" FROM CaseData AS T1 INNER JOIN ( SELECT geoId, SUM(cases) AS \"Total\" FROM CaseData GROUP BY geoId ORDER BY Total DESC LIMIT $shownCountries ) AS T2 ON Country = T2.geoId INNER JOIN CaseData AS T3 ON T1.dateFormatted >= T3.dateFormatted WHERE Country = T3.geoId GROUP BY Country, Date ORDER BY Country;" > $queryResult;

while IFS= read -r line
do
   grepArgument=$(echo "$line" | cut -c1-2);
   countryFile=$(mktemp ./$grepArgument.XXX);
   grep "$grepArgument" "$queryResult" > $countryFile;
   countryFiles+=($countryFile);
done < "$countries";

echo "set style line 1 lt rgb '#6a3d9a' lw 3" >> gnuplot.in;
echo "set style line 2 lt rgb '#1f78b4' lw 3" >> gnuplot.in;
echo "set style line 3 lt rgb '#b2df8a' lw 3" >> gnuplot.in;
echo "set style line 4 lt rgb '#33a02c' lw 3" >> gnuplot.in;
echo "set style line 5 lt rgb '#fb9a99' lw 3" >> gnuplot.in;
echo "set style line 6 lt rgb '#e31a1c' lw 3" >> gnuplot.in;
echo "set style line 7 lt rgb '#fdbf6f' lw 3" >> gnuplot.in;
echo "set style line 8 lt rgb '#ff7f00' lw 3" >> gnuplot.in;
echo "set style line 9 lt rgb '#cab2d6' lw 3" >> gnuplot.in;
echo "set style line 10 lt rgb '#a6cee3' lw 3" >> gnuplot.in;
echo "set term png size 1100,1500" >> gnuplot.in;
echo "set output 'graph.png'" >> gnuplot.in;
echo "set key at graph 0.35,0.95 Left reverse" >> gnuplot.in;
echo "set xlabel 'Date'" >> gnuplot.in;
echo "set ylabel 'Total Deaths by Country'" >> gnuplot.in;
echo "set ytics 0,2500,100000" >> gnuplot.in;
echo "set xtics 1577750400,432000,1977750400" >> gnuplot.in;
echo "set xtics rotate by 60 right" >> gnuplot.in;
echo "set datafile separator \"|\"" >> gnuplot.in;
echo "set xdata time" >> gnuplot.in;
echo "set format x \"%Y-%m-%d\"" >> gnuplot.in;
echo "set size ratio 1.36" >> gnuplot.in;
echo "set autoscale y" >> gnuplot.in;
echo "set autoscale x" >> gnuplot.in;
echo "set timefmt '%Y-%m-%d" >> gnuplot.in;
echo -n "plot " >> gnuplot.in;
for t in ${countryFiles[@]}; do
   i=$(($i + 1));
   countryCode=$(echo $t | cut -c3-4);
   countryName=$(sqlite3 coronavirus.db "SELECT countriesAndTerritories FROM CountryID WHERE geoId = '$countryCode';");
   countryName=$(echo $countryName | tr '_' ' ');
   echo "\"$t\" using 1:3 title \"$countryName\" with lines ls $i, \\" >> gnuplot.in;
done
gnuplot gnuplot.in

for t in ${countryFiles[@]}; do
   rm -rf $t;
done
rm -rf gnuplot.in;
rm -rf "$queryResult";
rm -rf "$countries";
