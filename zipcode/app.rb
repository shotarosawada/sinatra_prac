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

get '/' do

    @table = generate_table
    erb :index

end

# 新規登録処理
post '/new' do
    zipcode = params['zip_code']
    zipcode_hash = call_zipcodeAPI(zipcode)

    # エラー処理はサンプルコードを参考に作成
    @results = zipcode_hash[:results] || []
    p @results
    # 空値チェック
    if @results.empty?
        puts ('Requested zipcode is not exist.')
        @message = response[:message] || '指定した郵便番号は存在しません'
    else
        record = zipcode_hash[:results][0]
        # 同一Zipcodeの重複登録不可
        if(Zip_codes.find_by(zip_code: record[:zipcode]))
            puts ('Requested zipcode Already recorded.')
            @message = response[:message] || '登録済みの郵便番号です'
        # 登録処理
        else
            s = Zip_codes.new
            s.zip_code = record[:zipcode]
            s.prefecture = record[:address1]
            s.city = record[:address2]
            s.town_area = record[:address3]
            s.save
        end
    end

    @table = generate_table

    erb :index

end

# 削除処理
delete '/del' do

    target_record = Zip_codes.find(params[:id])
    target_record.destroy
    redirect '/'

end

def call_zipcodeAPI(zipcode)
    uri = URI("https://zipcloud.ibsnet.co.jp/api/search?zipcode=#{zipcode}")
    res = Net::HTTP.get_response(uri)
    json = res.body
    json2hash =  JSON.parse(json, symbolize_names: true)
    # puts res.body if res.is_a?(Net::HTTPSuccess)
    return json2hash
end

def generate_table
    records = Zip_codes.all
    table_tags = ""
    records.each do |record|
        table_tags += "<tr>"
        table_tags += "<td>#{record.id}</td>"
        table_tags += "<td>#{record.zip_code}</td>"
        table_tags += "<td>#{record.prefecture}</td>"
        table_tags += "<td>#{record.city}</td>"
        table_tags += "<td>#{record.town_area}</td>"
        table_tags += "<td>#{record.created_at}</td>"
        table_tags += "<td>#{record.updated_at}</td>"

        table_tags += "<form method=\"post\" action=\"/del\">"
        table_tags += "<td><input type=\"submit\" value=\"削除\"></td>"
        table_tags += "<input type=\"hidden\" name=\"id\" value=\"#{record.id}\">"
        table_tags += "<input type=\"hidden\" name=\"_method\" value=\"delete\">"
        table_tags += "</form>"

        table_tags += "</tr>\n"
    end
    return table_tags
end