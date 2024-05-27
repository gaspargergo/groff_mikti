#!/bin/sed -f

# Delete comments and blank lines
/^%/d
/^\s*$/d

# For each entry, replace BibTeX-specific tags with refer tags
s/@article{\(.*\),/\.B \1/
s/@book{\(.*\),/\.B \1/
s/@inproceedings{\(.*\),/\.B \1/
s/@incollection{\(.*\),/\.B \1/

# Replace BibTeX-specific tags with refer tags
s/author = {/A /
s/editor = {/A /
s/title = {/T /
s/journal = {/J /
s/booktitle = {/B /
s/year = {/D /
s/publisher = {/I /
s/pages = {/P /
s/edition = {/I /
s/volume = {/V /
s/number = {/N /
s/series = {/S /
s/institution = {/I /
s/address = {/A /
s/doi = {/D /

# Remove closing braces
s/}//g

# Replace comma with period after each tag
s/,/./

# Add a blank line after each entry
G
