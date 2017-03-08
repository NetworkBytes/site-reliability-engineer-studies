require "rest_client"
require "linkedin"


#p RestClient.methods.sort
#xml = RestClient.get 'http://example.com/resource'

#search(options = {}, type = 'people') ⇒ LinkedIn::Mash

LinkedIn.configure do |config|
  config.token = '86cf6pgfyfvlzd'
  config.secret = 'qLJJrnPWIQoxmtQu'
  #config.default_profile_fields = ['educations', 'positions']
end

client = LinkedIn::Client.new
#client = LinkedIn::Client.new('86cf6pgfyfvlzd', 'qLJJrnPWIQoxmtQu')

request_token = client.request_token({}, :scope => "r_basicprofile")

rtoken = request_token.token
rsecret = request_token.secret

client.authorize_from_access(rtoken, rsecret)

p client.search("John Bencic")