 
 
 
# TODO
# does not handle all zeros values correctly
# tidy up code
# potential test cases
# completed ## extract logic outside of __main__ function so that it can be potentially imported
 
# time taken on and off around 2.5 hours
# initial sudo code
 
# generate a 10 x 10 array of arrays
# create def for left / right most elements

# create dict to store results
# iterate through outer arrays
# if inner array contains a 1 (we have to evaluate)
#  if "top" is undefined set as top
#  set as bottom every time
#  call def to get left and right into results if  < or > results value
 
 
import random
def generate_blob(x=10, y=10):
  # https://stackoverflow.com/questions/33359740/random-number-between-0-and-1-in-python
  # random.randrange(0,2)
  # TODO: potentially clean up and use list comprehension
  y_list=[]
  for _ in range(y):
    x_list=[]
    for _ in range(x):
      x_list.extend(str(random.randrange(0,2)))
    y_list.append(x_list)
  return y_list
 
def print_list(list_to_print):
  import pprint
  pp = pprint.PrettyPrinter(indent=4)
  pp.pprint(list_to_print)
 
# Finds the left most "item" in list
def left_most_index(list, item="1"):
  increment_read()
  return list.index(item)
 
# Finds the right most "item" in list
def right_most_index(list, item="1"):
  increment_read()
  return len(list) - list[::-1].index(item)-1
 
# Finds if an "item" exists in list
def list_contains(list, item="1"):
  increment_read()
  return item in list
 
# print the results
def print_results(results):
  for key,value in results.items():
    #note dict will be unsorted (take a different approch if sorted output is desired)
    print("{0}: {1}".format(key, value))
 
def increment_read():
  results['Cell Reads'] = results['Cell Reads'] + 1

def process_blob(outer_list):
  horizontal_index = 0

  # loop all outer_list elements, which contain inner lists (list of lists)
  for inner_list in outer_list:
    # if list contains a 1 then we need to extract the details
    if list_contains(inner_list,"1"):

      # set the Top value if its less than the max value
      results['Top'] = horizontal_index if results['Top'] >= horizontal_index else None

      # find left
      l = int(left_most_index(inner_list))
      if l < results['Left']:
        results['Left'] = l

      # find right
      r = int(right_most_index(inner_list))
      if r > results['Right']:
        results['Right'] = r

      # always set the bottom if a 1 exists
      results['Bottom'] = horizontal_index

    horizontal_index += 1
    increment_read()
 
 
if __name__ == "__main__":
  max_x = 10
  max_y = 10

  # create an empty dictionary to store the results
  results= {
    'Cell Reads': 0,
    'Top':        max_y,
    'Left':       max_x,
    'Right':      0,
    'Bottom':     None,
  }

  outer_list=generate_blob(max_x, max_y)
  # pretty print list
  # coment this out if not required
  print_list(outer_list)

  # process the list populating the results dict
  process_blob(outer_list)

  # pint the results (unsorted however extendable)
  print_results(results)
