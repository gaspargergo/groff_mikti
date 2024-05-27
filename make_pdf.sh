#!/bin/bash

script=$(realpath "$0")
script_folder=$(dirname "$script")
source_file=$1
references=$2
reference_folder=$(dirname $references)

#populating header with correct paths and concatenating it with source file in a temp file
sed -e "s|%STYLESHEET%|$script_folder/sourcefiles/stylesheet.mom|" -e "s|%REF_FILE%|$script_folder/sourcefiles/extracts.mom|" -e "s|%REF_DB%|$script_folder/.temp_ref_db|" $script_folder/sourcefiles/header.mom | cat - $source_file > $script_folder/.temp_source.mom

#creating the to_SC file, by patching in earlier small caps, and calling the small caps script on new author fields
cp $references $reference_folder/to_sc
if [[ -f $reference_folder/sc.patch ]]; then patch $reference_folder/to_sc $reference_folder/sc.patch; fi
tools/choose-small-caps.sh $reference_folder/to_sc
diff $references $reference_folder/to_sc > $reference_folder/sc.patch

#running preconv, so refer can use the file with Hungarian chars as well, this temp file is substituted into the mom source file header
preconv $reference_folder/to_sc > $script_folder/.temp_ref_db

#before running groff, run the source file through a sed filter which looks for
#references in the [@reference] format, and changes the format to something groff can understand
#sed -e 's/\.REF \(.*\)/\\c\n\.REF\n\.\[\n\1\n\.\]\n\.REF\n/' $source_file 
#groff -Tpdf -mom -P-e -k -R $source_file > document.pdf
pdfmom -P-e -k -R $script_folder/.temp_source.mom > document.pdf

#cleanup
rm $reference_folder/to_sc $script_folder/.temp*
#only try to delete the patch rejects and original if they exist
if [[ -f $reference_folder/*.rej ]]; then rm $reference_folder/*.rej $reference_folder/*.orig; fi

