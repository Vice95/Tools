#!/bin/bash
clear
detectkernel () {                                                        kernel=( $(uname -srm) )
        kernel="${kernel[${#kernel[@]}-1]} ${kernel[@]:0:${#kerne
l[@]}-1}"
        [[ "$verbosity" -eq "1" ]] && verboseOut "Finding kernel
version...found as '$kernel'"
}                                                                # Kernel Version Detection - End

echo -e "\e[33m""Salve "$(whoami)
echo -e $(date)
/usr/games/fortune | /usr/games/cowsay -W50 -f tux
echo -e "Kernel:\t " $(uname -srm)
echo -e "Cpu:\t"$(awk 'BEGIN{FS=":"} /model name/ { print $2; exit }' /proc/cpuinfo | sed 's/ @/\n/' | head -1) " @ " $(awk -F':' '/cpu MHz/{ print int($2+.5) }' /proc/cpuinfo | head -n 1) " MHz"    
#lspci | grep VGA 
gpu_info=$(lspci 2> /dev/null | grep VGA)                        gpu=$(echo "$gpu_info" | grep -oE '\[.*\]' | sed 's/\[//;s/\]//')                                                                 gpu=$(echo "${gpu}" | sed -n '1h;2,$H;${g;s/\n/, /g;p}')  
echo -e "Gpu:\t"$gpu
echo -e "\e[1;32m""Temperatura"
echo -n "cpu: "
sensors | grep temp | awk {'print $2'}
echo -n "sda: +"
hddtemp /dev/sda | awk {'print $4'}
echo -n "sdb: +"
hddtemp /dev/sdb | awk {'print $4'}
echo -e "\e[1;35m""Spazio su disco"
df -h | grep /dev/sda4 | awk {'print "totale: " $2 "\n usato: "$3  "\nlibero: " $4'}
echo -e "\e[1;31m""Ram"
free -m -o | grep Mem: | awk {'print "Total:" $2 " MB\nUsed: " $3 "  MB\nFree: "$4" MB"'} | tr -d \(\)
echo -e "\e[1;34m""Network"
ifconfig eth0 | grep inet: | awk {'print "Local Ip: " $2'} | tr -d inet:
ifconfig eth0 | grep IndirizzoHW | awk {'print "MAC address: " $5 '}
curl -s ident.me | awk {'print "Public Ip: "$1"\n"'}
echo -e "\e[1;33m""Traffico di rete"
ifconfig eth0 | grep Byte | awk {'print "RX: " $3 " "$4 "\nTX: " $7 " " $8'} | tr -d \(\)
echo -e "\e[1;36m""Uptime"
uptime=$(</proc/uptime)
uptime=${uptime%%.*}
seconds=$(( uptime%60 ))
minutes=$(( uptime/60%60 ))
hours=$(( uptime/60/60%24 ))
days=$(( uptime/60/60/24 ))
echo "$days giorni, $hours ore, $minutes minuti, $seconds secondi"
echo -e "\e[1;31m""SMART monitor"
smartctl -H /dev/sda | grep test | awk {'print "/dev/sda: " $6'}
smartctl -H /dev/sdb | grep test | awk {'print "/dev/sdb: " $6'}
#echo -e "\e[1;34m""Stato RAID"
# cat /proc/mdstat | grep -v Perso | grep -v unused | awk ‘NF >0’ | tr -s “\t” ” ” | tr -s “\n” ” ” | awk {‘print $1 “: “$12 “\n” $13 “: ” $24’}
echo -e "\e[1;35m""Tentativi di accesso ordierni"
export LANG=en_us_8859_1
cat /var/log/auth.log | grep "`date +%b" "%d`" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | 
grep -v 192.168.1 | sort | uniq -c | sort -h | awk '{print $1"\t" $2 "\t" } { system("geoiplookup " $2 " | cut -d: -f2")} {print "|"}' | tr -d '\n' | tr -s '|' '\n'
echo -e "\e[1;33m""Accessi odierni"
cat /var/log/auth.log | grep Accepted | awk {'print $9'} | sort | uniq -c | awk {'print $2 "\t" $1'}
export LANG=it_IT.utf8
echo -e "\e[1;36m""Utenti connessi"
who | awk {'print $1"\t" $5'} | uniq -c | awk {'print $1"\t" $2"\t" $3'}
#echo -e "\e[33m""MOTD"
#/usr/games/fortune | /usr/games/cowsay -W50 -f tux
echo -e "\e[0m"

