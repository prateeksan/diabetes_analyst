# Homepage (Root path)
get '/' do
  erb :index
end

get '/user/signup' do
  @user = User.new
  erb :'/users/new'
end

get '/user/signin' do
  erb :'/session/new'
end

post '/user/signup' do
  @user = User.new(
    username: params[:username],
    password: params[:password],
    password_confirmation: params[:password_confirmation],
    first_name: params[:first_name],
    middle_name: params[:middle_name],
    last_name: params[:last_name],
    email: params[:email],
    birth_date: params[:birth_date],
    diagnosis_date: params[:diagnosis_date],
    height: params[:height],
    medical_history: params[:medical_history]
    )
  if @user.save
    redirect '/'
  else
    erb :'/users/new'
  end
end