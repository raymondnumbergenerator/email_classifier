#!/bin/sh

# all to lower case
sed -E 's/.*/\L&/' $1 >> $2

# remove commas
sed -i -E 's/,/ /g' $2

# replace our escape sequence with comma delimiter
sed -i -E 's/\!\!\!###\!\!\!/,/g' $2

# random stuff
sed -i -E 's/>+//g' $2
sed -i -E 's/<+//g' $2
sed -i -E 's/\\n/ /g' $2
sed -i -E 's/\r/ /g' $2

# remove quoted text
sed -i -E 's/---------- forwarded message ----------.*$//g' $2
sed -i -E 's/-------- original message --------.*$//g' $2

# remove emails
sed -i -E 's/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}//g' $2

# remove urls
sed -i -E 's/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/ /g' $2

# remove pgp keys
sed -i -E 's/-----begin pgp public key block-----.*-----end pgp public key block-----//g' $2
sed -i -E 's/-----begin pgp signature-----.*-----end pgp signature-----//g' $2

# clear non ascii characters
iconv -c -f utf-8 -t ascii $2 >> $2

# clear numbers
sed -i -E 's/[0-9]+/ /g' $2

# remove duplicate whitespace
sed -i -E 's/ +/ /g' $2

sed -i -E '1s/.*/subject,body/' $2
