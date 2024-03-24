#!/bin/bash

while test $# -gt 0; do
	case "$1" in
		-h|--help)
			echo "$package - Traductor de frases idiotas"
			echo 
			echo "$package application [option]  [argument]"
			echo 
			echo "options:"
			echo "-h, --help                muestra la ayuda"
			echo "-s, --sentence '<FRASE>'  añadir una frase idiota para traducir"
			echo
			echo "Si no se pasa ninguna opción, el programa pedirá la frase idiota para traducir"
			exit 0
			;;
		-s|--sentence)
			shift
	    		sentence=$1
	    		shift
	    		;;
	esac
done

echo 
echo $sentence | 
sed s/c[aou]/*i/g | #1
	sed s/c[áóú]/*í/g | #2
	sed s/c[ÁÓÚ]/*Í/g | #3
	sed s/c[AOU]/*I/g | #4
	sed s/C[aou]/+i/g | #5
	sed s/C[áóú]/+í/g | #6
	sed s/C[AOU]/+I/g | #7
	sed s/C[ÁÓÚ]/+Í/g | #8
	sed s/g[aou]/·i/g | #9
	sed s/g[áóú]/·í/g | #10
	sed s/g[ÁÓÚ]/·Í/g | #11
	sed s/g[AOU]/·I/g | #12
	sed s/G[aou]/¬i/g | #13
	sed s/G[áóú]/¬í/g | #14
	sed s/G[AOU]/¬I/g | #15
	sed s/G[ÁÓÚ]/¬Í/g | #16
	sed s/gu[ei]/·i/g | #9
	sed s/gu[éí]/·í/g | #10
	sed s/gu[ÉÍ]/·Í/g | #11
	sed s/gu[EI]/·I/g | #12
	sed s/GU[ei]/¬i/g | #13
	sed s/GU[éí]/¬í/g | #14
	sed s/GU[EI]/¬I/g | #15
	sed s/GU[ÉÍ]/¬Í/g | #16
	sed s/gü/·i/g | #9
	sed s/gÜ/·I/g | #12
	sed s/Gü/¬i/g | #13
	sed s/GÜ/¬I/g | #15
	tr aeou i | 
	tr AEOU I | 
	sed s/[áéóú]/í/g | 
	sed s/[ÁÉÓÚ]/Í/g | 
	sed s/*i/qui/g | #1
	sed s/*í/quí/g | #2
	sed s/*Í/quÍ/g | #3
	sed s/*I/quI/g | #4
	sed s/+i/Qui/g | #5
	sed s/+í/Quí/g | #6
	sed s/+I/QUI/g | #7
	sed s/+Í/QUÍ/g | #8
	sed s/·i/gui/g | #9
	sed s/·í/guí/g | #10
	sed s/·Í/gUÍ/g | #11
	sed s/·I/gUI/g | #12
	sed s/¬i/Gui/g | #13
	sed s/¬í/Guí/g | #14
	sed s/¬I/GUI/g | #15
	sed s/¬Í/GUÍ/g   #16
echo

length=${#sentence}

if [[ $length -eq 0 ]]; then
	read -p 'Frase idiota: ' sentence
	echo
	echo $sentence | 
	sed s/c[aou]/*i/g | #1
	sed s/c[áóú]/*í/g | #2
	sed s/c[ÁÓÚ]/*Í/g | #3
	sed s/c[AOU]/*I/g | #4
	sed s/C[aou]/+i/g | #5
	sed s/C[áóú]/+í/g | #6
	sed s/C[AOU]/+I/g | #7
	sed s/C[ÁÓÚ]/+Í/g | #8
	sed s/g[aou]/·i/g | #9
	sed s/g[áóú]/·í/g | #10
	sed s/g[ÁÓÚ]/·Í/g | #11
	sed s/g[AOU]/·I/g | #12
	sed s/G[aou]/¬i/g | #13
	sed s/G[áóú]/¬í/g | #14
	sed s/G[AOU]/¬I/g | #15
	sed s/G[ÁÓÚ]/¬Í/g | #16
	sed s/gu[ei]/·i/g | #9
	sed s/gu[éí]/·í/g | #10
	sed s/gu[ÉÍ]/·Í/g | #11
	sed s/gu[EI]/·I/g | #12
	sed s/GU[ei]/¬i/g | #13
	sed s/GU[éí]/¬í/g | #14
	sed s/GU[EI]/¬I/g | #15
	sed s/GU[ÉÍ]/¬Í/g | #16
	sed s/gü/·i/g | #9
	sed s/gÜ/·I/g | #12
	sed s/Gü/¬i/g | #13
	sed s/GÜ/¬I/g | #15
	tr aeou i | 
	tr AEOU I | 
	sed s/[áéóú]/í/g | 
	sed s/[ÁÉÓÚ]/Í/g | 
	sed s/*i/qui/g | #1
	sed s/*í/quí/g | #2
	sed s/*Í/quÍ/g | #3
	sed s/*I/quI/g | #4
	sed s/+i/Qui/g | #5
	sed s/+í/Quí/g | #6
	sed s/+I/QUI/g | #7
	sed s/+Í/QUÍ/g | #8
	sed s/·i/gui/g | #9
	sed s/·í/guí/g | #10
	sed s/·Í/gUÍ/g | #11
	sed s/·I/gUI/g | #12
	sed s/¬i/Gui/g | #13
	sed s/¬í/Guí/g | #14
	sed s/¬I/GUI/g | #15
	sed s/¬Í/GUÍ/g   #16
	echo
fi
