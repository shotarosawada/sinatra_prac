require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
#require 'activerecord'
#require 'sinatra-activerecord'
get '/' do
  db = SQLite3::Database.new("db/sinatra.db")
  db.execute("select * from myapp;") do |row|
    print row
  end
  db.close
end
