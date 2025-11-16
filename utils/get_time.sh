#!/bin/bash

if [[ $1 == "CET" ]]; then
    if [[ $2 == "static" ]]; then
       TZ=":CET" date +'%A, %d/%m/%Y %H:%M'
    elif [[ $2 == "dynamic" ]]; then
        TZ=":CET" date +'%A, %d/%m/%Y %H:%M:%S'
    else
        echo "Ivalid type ! Please use \"static\" or \"dynamic\""
        exit 2
    fi
elif [[ $1 == "AU" ]]; then
    if [[ $2 == "static" ]]; then
        TZ=":Australia/Melbourne" date +'%A, %d/%m/%Y %H:%M'
    elif [[ $2 == "dynamic" ]]; then
        TZ=":Australia/Melbourne" date +'%A, %d/%m/%Y %H:%M:%S'
    else
        echo "Ivalid type ! Please use \"static\" or \"dynamic\""
        exit 2
    fi
elif [[ $1 == "VN" ]]; then
    if [[ $2 == "static" ]]; then
        TZ=":Asia/Ho_Chi_Minh" date +'%A, %d/%m/%Y %H:%M'
    elif [[ $2 == "dynamic" ]]; then
        TZ=":Asia/Ho_Chi_Minh" date +'%A, %d/%m/%Y %H:%M:%S'
    else
        echo "Ivalid type ! Please use \"static\" or \"dynamic\""
        exit 2
    fi
else
    echo "Invalid region ! Please use \"CET\", \"AU\" or \"VN\""
    exit 1
fi

exit 0

