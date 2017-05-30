

s = "show me the split".split()

print s[3]  # extract the 3 element
print s[-2] # negative index from the right

# sliceing
# sequence[start:stop]
print s[2:4]
print s[2:]  # third element to end of list
print s[:3]  # all elements up to but not including third element


# append to list 
s.append("extra")
print s


# search for index of an element
e = s.index('extra')
print s[e]

# search for membership
'extra' in s      # True
'extra' not in s  # False

# remove by position
del s[3]

# remove by value
s.remove('extra')

#  sorting
s.sort(reverse=True) # sort by rverse order
s.sort(key=len)      # sort by length
sorted(s)            # builtin function returns a new sorted list 



# List comprehension
# [ expr(item) for item in iterable ]

print [len(item) for item in s]

