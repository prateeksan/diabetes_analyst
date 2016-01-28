helpers do
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/user/signup' do
  @user = User.new
  erb :'/users/new'
end

get '/user/signin' do
  @error = nil
  erb :'/session/new'
end

get '/user/signout' do
  session[:user_id] = nil
  redirect '/'
end

get '/user/foods/new' do
  if current_user 
    erb :'/users/foods/new'
  else
    redirect '/user/signin'
  end
end

post '/user/signin' do 
  @user = User.find_by(username: params[:username])

  if @user
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      #currently set to redirect to landing page. In future we can redirect to wherever the functionality is 
      redirect '/'
    else
      @error = "incorrect pasword, try again"
      erb :'/session/new'
    end      
  else
    @error = "username not found, try again"
    erb :'/session/new'
  end
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
    #currently set to redirect to landing page. In future we can redirect to wherever the functionality is 
    redirect '/'
  else
    erb :'/users/new'
  end
end

get '/aboutus' do
  erb :"about"
end