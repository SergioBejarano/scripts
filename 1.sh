#!/bin/sh
directorio(){
	read -r -p "directory: " directory
	if [ -z "$directory" ]; then
		directory="/"
	fi
}

recursivo(){
	ls -alh -R $directory
}

filtrar(){
	read -r -p "select type of filter (start, end, contains): " Ftype
	read -r -p "Enter the string: " string
	case "$Ftype" in
		"start")
			ls -alh $directory/$string*
			;;
		"end")
			ls -alh $directory/*$string
			;;
		"contains")
			ls -alh $directory/*$string*
			;;
		*)
			echo "invalid option."
			;;
	esac
}
ordenar(){
	read -r -p "select type of sort (recent, oldest, sizeLS 'large small', sizeSL 'small large', type): " Stype
	case "$Stype" in
		"recent")
			ls -alht  $directory | less
			;;
		"oldest")
			ls -alhtr $directory | less
			;;
		"sizeLS")
			ls -alhS $directory | less
			;;
		"sizeSL")
			ls -alhSr $directory | less
			;;
		"type")
			ls -alhX $directory | less
			;;
		*)
			echo "invalid option."
			;;
	esac
}

while true; do
	clear
	echo "select your directory and the next options"
	echo "Options:"
	echo " sort : sort the files depending the criteria (recent, oldest, sizels, sizesl, type)"
	echo " filter : filtering options depending the criteria (start, End, contains)"
	echo " recursive : recursive list all files, including subdirectories"
	read -r -p "opcion: " option
	directorio
	if [ ! -d "$directory" ]; then
		echo "directory $directory not found."
		exit 1
	fi
	case "$option" in
		"sort")
			ordenar
			;;
		"filter")
			filtrar
			;;
		"recursive")
			recursivo
			;;
		*)
			echo "opcion no valida"
			;;
	esac
	read -r -p "desea continuar? (y/n): " cont
	if [ "$cont" != "y" ]; then
		break
	fi
done

