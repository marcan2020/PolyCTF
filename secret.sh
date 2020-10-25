#!/bin/bash

cat /root/secrets/$1 | tr -d '\n' 
