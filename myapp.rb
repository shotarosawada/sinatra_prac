require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'activerecord'
require 'sinatra-activerecord'
get '/' do
  "Hello world"
end
