#!/bin/sh

# Solicitar información al usuario
echo "Ingrese el nombre de usuario:"
read USERNAME

echo "Ingrese el nombre del grupo:"
read GROUPNAME

echo "Ingrese el nombre completo del usuario:"
read FULLNAME

echo "Ingrese el directorio home del usuario:"
read HOMEDIR

echo "Ingrese la shell del usuario:"
read SHELL

echo "Ingrese los permisos de usuario (ej. 700):"
read PERM_USER

echo "Ingrese los permisos de grupo (ej. 770):"
read PERM_GROUP

echo "Ingrese los permisos de otros (ej. 755):"
read PERM_OTHER

echo "Ingrese el GID del grupo:"
read GID

# Crear grupo si no existe
if ! grep -q "^$GROUPNAME:" /etc/group; then
    echo "Creando grupo $GROUPNAME con GID $GID..."
    groupadd -g "$GID" "$GROUPNAME"
fi

# Crear usuario
echo "Creando usuario $USERNAME..."
useradd -m -d "$HOMEDIR" -s "$SHELL" -c "$FULLNAME" -g "$GROUPNAME" "$USERNAME"

# Asignar permisos al home del usuario
echo "Asignando permisos..."
chmod "$PERM_USER" "$HOMEDIR"
chmod "$PERM_GROUP" "$HOMEDIR"
chmod "$PERM_OTHER" "$HOMEDIR"

echo "Usuario y grupo creados exitosamente."
