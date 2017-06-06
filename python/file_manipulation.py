import os


def mkdirp(directory):
  if not os.path.isdir(directory):
    os.makedirs(directory)



def makefiles(directory):
  mkdirp(directory)
  [ write_content("{}/{}.txt".format(directory, file)) for file in range(10) ]


def write_content(file_name, count=0):
  if count > 10: return
  with open(file_name, "a+") as file_handle:
    print "Writing: {} to file {}".format(count, file_name)
    file_handle.write("{}\n".format(count))
  count += 1
  write_content(file_name, count)


if __name__ == "__main__":
  path = "/tmp/test"
  makefiles(path)
  print os.listdir(path)
