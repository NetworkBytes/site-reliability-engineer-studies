require "linkedin"

LinkedIn.configure do |config|
  config.token = '86cf6pgfyfvlzd'
  config.secret = 'qLJJrnPWIQoxmtQu'
end

client = LinkedIn::Client.new

request_token = client.request_token({}, :scope => "r_basicprofile")

rtoken = request_token.token
rsecret = request_token.secret

client.authorize_from_access(rtoken, rsecret)

p client.search("????")

#Untested