class Class:
  
  def __init__(self, number=1):
  	self._number = number

  def number(self):
  	return self._number

  def multiply(self):
  	return self._number * self._number




from ClassFile import Class

c = Class()
c.number()

d = Class(number=100)
d.multiply()
