#!/bin/bash

while test $# -gt 0; do
	case "$1" in
		-s|--sentence)
			shift
	    		sentence=$1
	    		shift
	    		;;
	esac
done

echo $sentence | tr [:lower:] [:upper:]

length=${#sentence}

if [[ $length -eq 0 ]]; then
	read -p 'Sentence: ' sentence
	echo $sentence | tr [:lower:] [:upper:]
fi
