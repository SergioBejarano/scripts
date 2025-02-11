#!/bin/sh

# Function to create a new user
create_user() {
    username=$1
    group=$2
    fullname=$3
    home_dir=$4
    shell=$5
    dir_perm=$6
    file_perm=$7
    exec_perm=$8

    # Create the user with the specified details
    useradd -m -s "$shell" -c "$fullname" -d "$home_dir" -g "$group" "$username"

    # Set directory permissions
    chmod "$dir_perm" "$home_dir"

    # Set file permissions for the user's home directory
    find "$home_dir" -type f -exec chmod "$file_perm" {} \;

    # Set execute permissions for the user's home directory
    find "$home_dir" -type f -exec chmod "$exec_perm" {} \;
}

# Function to create a new group
create_group() {
    groupname=$1
    group_id=$2

    # Create the group with the specified group ID
    groupadd -g "$group_id" "$groupname"
}

# Main script execution
if [ "$#" -ne 8 ]; then
    echo "Usage: $0 <username> <group> <fullname> <home_dir> <shell> <dir_perm> <file_perm> <exec_perm>"
    exit 1
fi

create_user "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
create_group "$2" "$9"
