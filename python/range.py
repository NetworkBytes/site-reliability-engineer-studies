

# range(stop)
# range(start, stop)
# range(start, stop, step)

r = range(1,11)
for p in enumerate(r):
  print(p)

# enumerate() yelds (index, value) 
#(0, 1)
#(1, 2)
#(2, 3)
#(3, 4)

for index, val in enumerate(r):
  print ("index: {}, value:{}".format(index, val))
 
#index: 0, value:1
#index: 1, value:2




