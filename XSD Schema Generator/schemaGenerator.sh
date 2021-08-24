#!/bin/bash

tmpdir="./_schematemp_"
dirname="$(basename "$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )")"
schemaname=${dirname}_XMLSchema.xsd

echo "======= XSD Generator ========="
echo "tmpdir: $tmpdir"
echo "dirname: $dirname"
echo "schemaname: $schemaname"
echo "==============================="

i=0
mkdir $tmpdir
echo "Copying XML files to $tmpdir ..."
while IFS= read -r -d '' file
do
	hash=$(echo "$file" | sha1sum | head -c 40)
	cp "$file" "$tmpdir/$hash.xml"
	i=$((i+1))
done <   <(find mods -type f -iname '*.xml' -print0)
echo "Copied $i xml files"
echo "Generating $schemaname from $i xml files"
java -jar ../trang.jar -I xml -O xsd $tmpdir/*.xml $schemaname
echo "Deleting $tmpdir"
rm -rf $tmpdir
echo "=============Complete!============"