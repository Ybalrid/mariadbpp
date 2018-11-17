#!/bin/bash

#list source files
srcfiles=$(ls src/)
includefiles=$(cd include/mariadb++ && ls *.hpp)

#configure output and token to define to implement
output=include/mariadb++/mariadb.hpp
implflag=MARIADB_HO_IMPL

#write file content
echo -e "//FILE AUTOMATICALLY GENERATED\n//commit: $(git rev-parse HEAD)" > $output

for i in $includefiles
do
	echo -e "#include \"$i\"" >> $output
done

echo -e "#ifdef $implflag\n\n" >> $output

for i in $srcfiles
do
	echo -e "\n\n// $i" >> $output
	cat src/$i >> $output
done
echo "#endif //$implflag" >> $output

#fix end of line characters
if [ "$(uname)" != "linux" ]
then
	dos2unix $output
fi
