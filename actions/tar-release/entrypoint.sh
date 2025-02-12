#! /bin/bash
# Create archive or exit if the command fails
set +e

printf "\n📦 Creating tarball archive...\n"

if [ "$INPUT_DIRECTORY" != "." ] 
then
  cd "$INPUT_DIRECTORY"
fi

if [ -z "$INPUT_EXCLUSIONS" ] 
then
  tar -zcvf --warning=no-file-changed "$INPUT_FILENAME" . || { printf "\n⛔ Unable to create %s archive.\n"; exit 1;}
else
  EXCLUSIONS=''
  for EXCLUSION in $INPUT_EXCLUSIONS
  do
    EXCLUSIONS+=" --exclude="
    EXCLUSIONS+=$EXCLUSION
  done
  tar $EXCLUSIONS -zcvf --warning=no-file-changed "$INPUT_FILENAME" . || { printf "\n⛔ Unable to create %s archive.\n"; exit 1;}
fi

printf "\n✔ Successfully created tarball archive.\n"