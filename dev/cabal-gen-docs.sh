#!/usr/bin/env sh

# Meant to be run from the root of the project repository.

projectName=$(basename $(pwd))

date +"%T"

printf "\nGenerating Haddock documentation...\n"
cabal haddock --enable-documentation --haddock-hyperlink-source all

if ! command -v hoogle &> /dev/null
then
    printf "\nhoogle not found. Skipping hoogle database generation.\n"
else
    printf "\nGenerating hoogle database...\n"
    # TODO add --download flag?
    dbName=$projectName.hoo
    hoogle generate --local --database dbName
fi

printf "\nGenerated docs original location:\n"
find ./dist-newstyle -name doc -exec readlink -f {} \;
# find ./ -name doc


mkdir -p ./docs

printf "\nCopying docs into ./docs...\n"
sudo find . -name doc | xargs -i cp -R -f {} ./docs 2>/dev/null


printf "\nDocs entrypoints:\n"
find ./docs -name index.html -exec readlink -f {} \;
# find ./docs -name index.html

echo ""
date +"%T"
