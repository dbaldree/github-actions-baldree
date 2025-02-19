#! /bin/bash
# Create archive or exit if the command fails
set +e

printf "\n📦 Creating tarball archive...\n"

if [ "$INPUT_DIRECTORY" != "." ] 
then
  if [ -d $INPUT_DIRECTORY ]; then
    echo "Directory exists."
  else
    mkdir -p "$INPUT_DIRECTORY"
  fi
fi

cd "$INPUT_DIRECTORY"
touch "$INPUT_FILENAME"

if [ -z "$INPUT_EXCLUSIONS" ] 
then  
  tar -zcvf "$INPUT_FILENAME" . || { printf "\n⛔ Unable to create %s archive.\n";printf "\ntar -zcvf \"$INPUT_FILENAME.$INPUT_RELEASE\" .\n"; exit 1;}
else
  EXCLUSIONS=""
  for EXCLUSION in $INPUT_EXCLUSIONS
  do
    EXCLUSIONS+=" --exclude="
    EXCLUSIONS+=$EXCLUSION
  done
  tar $EXCLUSIONS -zcvf "$INPUT_FILENAME" . || { printf "\n⛔ Unable to create %s archive.\n";printf "\ntar $EXCLUSIONS -zcvf \"$INPUT_FILENAME.$INPUT_RELEASE\" .\n"; exit 1;}
fi

printf "\n✔ Successfully created tarball archive.\n"