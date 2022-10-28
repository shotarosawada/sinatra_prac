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
        if(Zip_codes.find_by(zip_code: record[:zipcode]))
            puts ('Requested zipcode Already recorded.')
            # 更新処理
            target_record = Zip_codes.find_by(record[:zip_code])
            target_record[:updated_at] = Time.new
            target_record.save
        else
            # 登録処理
            inserting_record = Zip_codes.new
            inserting_record.zip_code = record[:zipcode]
            inserting_record.prefecture = record[:address1]
            inserting_record.city = record[:address2]
            inserting_record.town_area = record[:address3]
            inserting_record.save
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