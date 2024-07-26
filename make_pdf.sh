#!/bin/bash

script=$(realpath "$0")
script_folder=$(dirname "$script")
source_file=$1
references=$2
reference_folder=$(dirname $references)

#--- FORMATTING REFERENCE DATABASE ---
#patching previous small caps choices if present before choosing scmall caps if new names were added
cp $references $reference_folder/to_sc
if [[ -f $reference_folder/sc.patch ]]; then patch $reference_folder/to_sc $reference_folder/sc.patch; fi
#run the small caps position choosing script for new authors; if there is no need, it simply quits
$script_folder/tools/choose-small-caps.sh $reference_folder/to_sc
diff $references $reference_folder/to_sc > $reference_folder/sc.patch

#running preconv, so refer can use the file with Hungarian letters as well
preconv $reference_folder/to_sc > $script_folder/.temp_ref_db

#--- FORMATTING SOURCE FILE ---
#concatenating source file with ref_macros, ref_header, stylesheet and bibliography
cat $script_folder/sourcefiles/extracts.mom $script_folder/sourcefiles/header.mom $script_folder/sourcefiles/stylesheet.mom $source_file $script_folder/sourcefiles/bibliography.mom > $script_folder/.temp_source.mom

#populating source file with correct paths for stylesheet, reference implementation, and reference database
sed -i -e "s|%REF_DB%|$script_folder/.temp_ref_db|" $script_folder/.temp_source.mom

#--- COMPILATION AND CLEANUP ---
pdfmom -P-e -k -R $script_folder/.temp_source.mom > $3

#cleanup
rm $reference_folder/to_sc $script_folder/.temp*
#only try to delete the patch rejects and original if they exist
if [[ -f $reference_folder/*.rej ]]; then rm $reference_folder/*.rej $reference_folder/*.orig; fi

