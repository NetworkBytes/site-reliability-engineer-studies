# Fizz Buzz


def generate_output(start, end):
  for num in xrange(start - 1, end + 1):
  	if num % 3 == 0 and num % 5 == 0:
  		print "FizzBuzz"
  	elif num % 3 == 0:
  		print "Fizz"
  	elif num % 5 == 0:
  		print "Buzz"
  	else:
  	  print num 



if __name__  == "__main__":
  generate_output(1,100)

