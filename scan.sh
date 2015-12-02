#!/bin/bash
nmap 192.168.1.1-254 -sn | grep "scan report" | awk '{print $5}'
