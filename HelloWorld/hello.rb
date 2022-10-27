require 'sinatra'

get '/' do
    @msg = "what you are".upcase
    erb :index
end