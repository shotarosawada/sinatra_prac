require 'uri'
require 'net/http'

uri = URI('https://zipcloud.ibsnet.co.jp/api/search?zipcode=8614113')
res = Net::HTTP.get_response(uri)
puts res.body if res.is_a?(Net::HTTPSuccess)