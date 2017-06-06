

# joininig a string
a = ''.join(['I','am','joined'])
print a

b = 'I'
b += 'am'
b += 'joined'
print b
	
# partitions, similar to split
origin, _, destination = 'Sydney:New York'.partition(':')
print origin+destination

# string format
"origin is: {0} destination is: {1}".format('Sydney', 'New York')
"origin is: {}  destination is: {} ".format('Sydney', 'New York')
"origin is: {named1}  destination is: {named2} ".format(named1='Sydney', named2='New York')

# create tuple and string format
# note round brackets created a tuple vs list
pos = (12.3, 23.6, 9.2)
"origin is at {pos[0]}, {pos[1]} ".format(pos=pos)

# format 3 decimal places
"formatted number {:.3f}".format(3.123456789)


# split
"I am a string".split('a')

# Slice 
#'slice'[start:end:increment]
'0123456789'[1:6:2]  # prints 135
'slice'[1]     # prints 'l'
'slice'[:2]    # prints sl
'slice'[1:]    # prints 'lice'
'slice'[1:2]   # prints 'li', start, end

# find in string
# str.find(str, beg=0, end=len(string))
'string'.find('r')


# RegEx replace
import re
# re.sub(regex_search,regex_replace,contents)
print re.sub('a+','b',"aaaaaabcdefg")