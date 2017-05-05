#!/usr/bin/python

input = int(raw_input(""))
print int(bin(input)[2:][::-1], 2) 
