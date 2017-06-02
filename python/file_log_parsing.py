
# Open file access_log and count all hits per client


source_file = '../sample_files/access_log'

client_hits = {}

with open(source_file) as fso:
  for line in fso:
    #client = line[:line.find(' ')]
    client = line.split()[0]

    if client in client_hits.keys():
      client_hits[client] = client_hits[client] + 1
    else:
      client_hits[client] = 1


print client_hits


