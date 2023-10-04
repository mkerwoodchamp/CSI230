#! /bin/bash

logFile="access.txt"
input="access.txt"
if [[ ! -f "${logFile}" ]]
then
	bash combinelog.bash
fi

:> report.html

echo '<html>\n<head>\n<title> Report of log files </title>\n</head>' >> report.html

echo '<body>\n<table>\n<tr>\n<td>IP</td>\n<td>Time</td>\n<td>Requested Page</td>\n<td>User Agent</td>\n</tr>' >> report.html


while read -r line
do
echo '<tr>' >> report.html
ip=cut $line -d ' ' -f 1
times=cut $line -d ' ' -f 4 | tr -d '[' | cut -c 14
page=cut $line -d ' ' -f 7 | tr -d '/'
user=cut $line -d ' ' -f 12 | tr -d '"' 'curl'

echo '<td>${ip}</td>' >> report.html
echo '<td>${times}</td>' >> report.html
echo '<td>${page}</td>' >> report.html
echo '<td>${user}</td>' >> report.html 
echo '</tr>'
done<$input
echo '</table>\n</body>\n</html>'

cp "report.html" "~/var/www/html/"
