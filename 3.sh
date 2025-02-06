#!/bin/sh
ultimo(){
	for files in /var/log/messages /var/log/authlog /var/log/Daemon.log; do
		echo "las 15 lines of system $files: "
		less "$files" | tail -n 15
	done

}

filtrar(){
	read -r -p "Word?: " word
	for files in /var/log/messages /var/log/authlog /var/log/Daemon.log; do
		echo "las 15 lines of system $files with the Word $word"
		less "$files" | tail -n 15 | grep "$word"
	done
}

while true; do
	clear
	echo "Write a shell script that"
	echo "Options:"
	echo " last : Show the last 15 lines of 3 log files that contain general system activity data."
	echo " filter : Filter those 15 lines from the same log files to display only those containing a specific word."
	read -r -p "opcion: " option
	directorio
	case "$option" in
		"last")
			ultimo
			;;
		"filter")
			filtrar
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