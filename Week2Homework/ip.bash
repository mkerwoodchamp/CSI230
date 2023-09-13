ip addr | awk '/inet / {split($2, a); print a[1]}' | grep -v "127"
: '
Some things found at
gnu.org/software/gawk/manual/html_node/String-Functions.html
and
www.geeksforgeeks.org/grep-command-in-unixlinux/#

'
