# Homepage (Root path)
get '/' do
  erb :index
end

get '/signup' do
  erb :'/users/new'
end

get '/signin' do
  erb :'/session/new'
end