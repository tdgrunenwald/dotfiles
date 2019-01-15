#!/bin/sh

# symlinks the given file to the given directory
# creates a backup before replacing files if they already exist
# linkFiles <file> <where to put it>
linkFile() {
	FNAME=$(basename $1)
	$([ -f $2/$FNAME ] || [ -d $2/$FNAME ]) && mv $2/$FNAME $2/$FNAME.backup && echo "created $FNAME.backup."
	echo -n "linking $FNAME..."
	ln -s $1 $2/$FNAME
	echo "OK!"
}

# change working directory to the containing directory of this script
# (should be the repository)
cd $(dirname $0)

# create local scripts directory if it doesn't exist
[ -d $HOME/.scripts ] || mkdir $HOME/.scripts

# link scripts
for F in $PWD/.scripts/*; do 
	linkFile $F $HOME/.scripts
done

# link configs
for F in $PWD/.config/*; do 
	linkFile $F $HOME/.config
done

for F in $PWD/.*; do
	[ -f $F ] && linkFile $F $HOME
done

