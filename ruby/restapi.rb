require "rest_client"


# p RestClient.methods.sort
request = RestClient.get 'https://jsonplaceholder.typicode.com/posts/1'


if request.code < 400
  response_hash = JSON.parse(request.body)

# ITERATE KEY VALUE HASH
  response_hash.each { |k,v|
    puts "Key: %s\nValue: %s\n\n" % [k,v]
  }
# OR TO GET ONE VLAUE FROM HASH
  puts response_hash["title"]

end
