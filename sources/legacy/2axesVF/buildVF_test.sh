#!/bin/sh
set -e

echo "Generating Variable Font"
mkdir -p ./fonts/variable
fontmake -g Sources/Mojilogue.glyphs -o variable --output-path ./fonts/variable/Mojilogue[ital,wght].ttf
statmake --stylespace Sources/stat.stylespace --designspace ./master_ufo/Mojilogue.designspace ./fonts/variable/Mojilogue\[ital\,wght\].ttf

rm -rf master_ufo/ instance_ufo/

echo "Post processing VFs"
vf=$(ls ./fonts/variable/Mojilogue[ital,wght].ttf)
gftools fix-nonhinting $vf $vf.fix
mv $vf.fix $vf
gftools fix-dsig --autofix $vf;
gftools fix-unwanted-tables --tables MVAR $vf

rm ./fonts/variable/*gasp*

echo "Complete!"
