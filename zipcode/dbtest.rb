require 'sinatra'
require 'active_record'
require 'uri'
require 'net/http'
require "json"

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection :development

class Zip_codes < ActiveRecord::Base
    self.table_name = 'zip_codes'
end

# 日本語形式の日付に変換
# @param
# @return [String] 日付を YYYY年MM月DD日 の形式にしたもの
# @return [nil] 引数が Date 型以外の場合は nil
get '/' do
    t = Zip_codes.all

    @h = ""
    t.each do |a|
        @h = @h + "<tr>"
        @h = @h + "<td>#{a.id}</td>"
        @h = @h + "<td>#{a.zip_code}</td>"
        @h = @h + "<td>#{a.prefecture}</td>"
        @h = @h + "<td>#{a.city}</td>"
        @h = @h + "<td>#{a.town_area}</td>"
        @h = @h + "<td>#{a.created_at}</td>"
        @h = @h + "<td>#{a.updated_at}</td>"
        @h = @h + "</tr>\n"
    end

    erb :index
end

post '/new' do
    # zipcode = params.zip_code
    # zipcode_hash = call_zipcodeAPI(zipcode)
    zipcode_hash = call_zipcodeAPI(2360038)
    record = zipcode_hash[:results][0]
    s = Zip_codes.new
    # s.id = record[:id]
    s.zip_code = record[:zipcode]
    s.prefecture = record[:address1]
    s.city = record[:address2]
    s.town_area = record[:address3]
    s.save
    redirect '/'
end

def call_zipcodeAPI(zipcode)
    uri = URI("https://zipcloud.ibsnet.co.jp/api/search?zipcode=#{zipcode}")
    res = Net::HTTP.get_response(uri)
    json = res.body
    json2hash =  JSON.parse(json, symbolize_names: true)
    return json2hash
    # puts res.body if res.is_a?(Net::HTTPSuccess)
end


# results = json2hash[:results][0]

# id = ""
# zipcode = results[:zipcode]
# pref = results[:address1]
# city = results[:address2]
# local = results[:address3]
# createtime = 1970
# updatetime = 2022
