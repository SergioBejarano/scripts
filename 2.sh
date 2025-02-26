#!/bin/sh

while true; do
    echo "\nFile Search and Viewing Menu:"
    echo "1. Search for a file in a directory"
    echo "2. Search for a word in a file"
    echo "3. Search for a file and a word inside it"
    echo "4. Count the number of lines in a file"
    echo "5. Display the first n lines of a file"
    echo "6. Display the last n lines of a file"
    echo "7. Exit"
    read -p "Choose an option: " option

    case $option in
        1)
            read -p "Enter directory: " dir
            read -p "Enter filename or part of it: " filename
            results=$(find "$dir" -type f -name "*$filename*" 2>/dev/null) # Buscar archivos en el directorio especificado
            echo "$results"
            echo "Total occurrences: $(echo "$results" | wc -l)"  # Contar el numero de archivos encontrados
            ;;
        2)
            read -p "Enter file path: " file
            read -p "Enter word to search: " word
            grep -n "$word" "$file" # Buscar la palabra en el archivo e imprimir con numero de linea
            echo "Total occurrences: $(grep -c "$word" "$file")" # Contar el numero de apariciones de la palabra
            ;;
        3)
            read -p "Enter directory: " dir
            read -p "Enter filename or part of it: " filename
            read -p "Enter word to search: " word
            # Buscar archivos que coincidan con el nombre y luego buscar la palabra dentro de cada uno
            find "$dir" -type f -name "*$filename*" 2>/dev/null | while read -r file; do
                echo "Searching in: $file" # Mostrar el archivo en el que se busca la palabra
                grep -n "$word" "$file" # Buscar la palabra dentro del archivo con numero de linea
                echo "Total occurrences: $(grep -c "$word" "$file")" # Contar el número de apariciones de la palabra
            done
            ;;

        4)
            read -p "Enter file path or filename: " file

            # Verificar si el archivo existe
            if [ -f "$file" ]; then
                echo "Total lines: $(wc -l < "$file")" # Contar las lineas en el archivo
            else
                echo "File not found: $file" # Mensaje de error si el archivo no existe
            fi
            ;;


        5)
            read -p "Enter file path: " file
            read -p "Enter number of lines to display: " n
            head -n "$n" "$file" # Mostrar las primeras n lineas del archivo
            ;;
        6)
            read -p "Enter file path: " file
            read -p "Enter number of lines to display: " n
            tail -n "$n" "$file" # Mostrar las últimas n lineas del archivo
            ;;
        7)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
done
