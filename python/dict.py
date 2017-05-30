

# unordered mapping from unique, immutable keys to mutable values

d = {
      'key1':'value1',
      'key2':'value2',
      'key3':'value3',
      'key4':'value4'
    } 

print d
print d['key2']

# merge two dict's using update
# if key exists it updates the value
e = { 'key4':'newvalue4', 'key5':'value5' }
d.update(e)
print d


# iterate key value pairs
for key in d:
  print "{key} => {val}".format(key=key, val=d[key])

# iterate values usin values()
for val in d.values():
  print val

# iterate key, value items using items()
for k, v in d.items():
  print "{} => {}".format(k, v)


# find key in  dict
'key1' in d

# remove element
del d['key1']

# add element to dict 
d['key6'] = 'value6'


# Dict comprehension
# { key_expr:value_expr for item in iterable }
# sample reverse's value to key from a dict 
print { val: key for key, val in d.items() }

import os
import glob
file_sizes = { os.path.realpath(p): os.stat(p).st_size for p in glob.glob('*.py') }
print file_sizes