default: cbuild

# Unfamiliar with 'just'? See https://github.com/casey/just

set ignore-comments := true

# NOTE all commands are executed as though from a shell at the project root,
# regardless of where you may be in a shell inside the project when you invoke
# a recipe.

alias cb := cbuild
alias ct := ctest
alias d := doc
alias t := tags
alias hg := hoog
alias hd := hadd
alias n := nbuild
alias crp := cachix

cbuild:
  cabal build

ctest:
  cabal test

doc:
  ./dev/cabal-gen-docs.sh

nbuild:
  nix build

ndev:
  nix develop

cachix:
  nix build --json | jq -r '.[].outputs | to_entries[].value' | cachix push emeinhardt

tags:
  haskdogs --hasktags-args -ex

hoog-start:
  ./dev/hoogle-start.sh

hadd:
  ./dev/haddock-open.sh

hoog:
  ./dev/hoogle-open.sh
