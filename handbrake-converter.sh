#!/bin/bash -e

if [ -z "$2" ]; then
	echo "Usage: $0 <source path for recursive movie search> <output path>"
	exit 1
elif [ ! -d "$1" ]; then
	echo "Source path does not exist: $1"
	exit 1
elif [ ! -d "$2" ]; then
	echo "Destination path does not exist: $2"
	exit 1
fi

SRC="$1"
DST="$2"
EXT="mp4"
PRESET="iPad"
RM_SRC="true"

case "$uname" in
	Darwin)
if [ "$(which trash)" ]; then
	RM_CMD="trash"
else
	echo "Requires trash utility. Install with: brew install trash"
	exit 1
fi
;;

	*)
RM_CMD="rm -rf"
;;

esac

find -E "$SRC" -type f -regex '.*\.(mkv|mp4)' | grep -v \/Sample\/ | while read line
do
	outfile="$(basename "$line")-$PRESET.$EXT"
	if [ ! -e "$DST/$outfile" ]; then
		# Note the echo. Required, otherwise HandBrakeCLI breaks the while loop. Don't know why.
		echo ""  | HandBrakeCLI --preset="$PRESET" -i "$line" -o "$DST/$outfile"
		if [ "$RM_SRC" ]; then
			$RM_CMD "$line"
		fi
	fi
done
