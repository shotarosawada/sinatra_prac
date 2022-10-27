require 'sinatra'
require 'active_record'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection :development

class BBSdata < ActiveRecord::Base
    self.table_name = 'bbsdata'
end

a = BBSdata.find(1)

get '/' do
    t = BBSdata.all

    @h = ""
    t.each do |a|
        @h = @h + "<tr>"
        @h = @h + "<td>#{a.id}</td>"
        @h = @h + "<td>#{a.name}</td>"
        @h = @h + "<td>#{a.entry}</td>"
        @h = @h + "</tr>\n"
    end

    erb :index
end
