#!/bin/sh

#Uso delle variabili d'ambiente

echo "Informazioni sul sistema:"
echo -e "hostname: $HOSTNAME"
echo -e "hardware: $HOSTTYPE"
echo -e "OS: $OSTYPE"

echo "Informazioni sull'utente:"
echo -e "logname: $LOGNAME"
echo -e "homedir: $HOME"
echo -e "shell: $SHELL"
echo -e "path: $PATH"
