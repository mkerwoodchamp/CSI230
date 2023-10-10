#! /bin/bash

logFile="access.txt"
if [[ ! -f "${logFile}" ]]
then
	bash combinelog.bash
fi

:> report.html

cat <<EOL > report.html
<html>
<head>
<title>Report of log files</title>
</head>
<body>
<table>
<tr>
<td>IP</td>
<td>Time</td>
<td>Requested Page</td>
<td>User Agent</td>
</tr>
EOL


while read -r line
do
echo '<tr>' >> report.html
ip=$(echo "$line" | cut -d ' ' -f 1)
times=$(echo "$line" | cut -d ' ' -f 4 | tr -d '[')
page=$(echo "$line" | cut -d ' ' -f 7 | tr -d '/')
user=$(echo "$line" | cut -d ' ' -f 12 | tr -d '"')

echo "<td>${ip}</td>" >> report.html
echo "<td>${times}</td>" >> report.html
echo "<td>${page}</td>" >> report.html
echo "<td>${user}</td>" >> report.html 
echo '</tr>' >> report.html
done<"$logFile"
echo '</table></body></html>' >> report.html

cp "report.html" "/var/www/html/"
