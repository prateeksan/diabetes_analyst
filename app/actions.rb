helpers do
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def add_date_to_time(time)
    Date.today.to_s + " " + time   
  end

  def bmi_calculator(user)
    if user && user.patient_measurements.last && user.patient_measurements.last.weight
      (user.patient_measurements.last.weight.to_f / user.height.to_f / user.height.to_f * 10000).floor
    else
      0
    end
  end
    
  def filter_n_day(n,arr)
    if n == 0
      new_arr = arr.where(created_at: (Time.now-((Time.now.hour*3600)+(Time.now.min*60)+Time.now.sec))..Time.now)
    else
      new_arr = arr.where(created_at: (n.day.ago-((Time.now.hour*3600)+(Time.now.min*60)+Time.now.sec))..((n-1).day.ago-((Time.now.hour*3600)+(Time.now.min*60)+Time.now.sec)))
    end
  end
  
  def date_time_now_for_html
    ruby_time = (Time.now - 18000).to_s
    html_time = "#{ruby_time[0..9]}T#{ruby_time[11..15]}"
  end

  def time_now_to_midnight
    ruby_time = (Time.now - 18000).to_s
    ruby_time[0..9]
  end

  def utc_to_local(time)
    (time-18000).to_s[0..18]
  end

end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/user/signup' do
  redirect "/user/#{current_user.id}" if current_user
  @user = User.new
  erb :'/users/new'
end

get '/user/signin' do
  redirect "/user/#{current_user.id}" if current_user
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

get "/autocomplete_food_name" do
  result =[]
  pattern = params["term"].downcase
  if pattern.length >= 2
    content_type :json
    matches = Food.where("lower(name) LIKE '#{pattern}%'")
    matches.each do |match|
      result << match[:name]
    end
  end
  result.to_json
end

get "/fooditem" do
  food_name = params[:food_name]
  item = Food.find_by(name: "#{food_name}")
  item_name = item.measure
  content_type :json
  "#{item_name}".to_json
end

get "/autocomplete_med_name" do
  result =[]
  pattern = params["term"].downcase
  if pattern.length >= 2
    content_type :json
    matches = Medication.where("lower(name) LIKE '#{pattern}%'")
    matches.each do |match|
      result << match[:name]
    end
  end
  result.to_json
end

get "/meditem" do
  med_name = params[:med_name]
  item = Medication.find_by(name: "#{med_name}")
  item_din = item.din
  content_type :json
  "#{item_din}".to_json
end

post '/user/signin' do 
  @user = User.find_by(username: params[:username])

  if @user
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      #currently set to redirect to landing page. In future we can redirect to wherever the functionality is 
      redirect "/user/#{@user.id}"
    else
      @error = "incorrect pasword, try again"
      erb :'/session/new'
    end      
  else
    @error = "username not found, try again"
    erb :'/session/new'
  end

end

get '/user/:id' do
    @user = current_user
  if @user && params[:id].to_i == @user.id
    erb :'/users/dashboard'
  else
    session[:user_id] = nil
    redirect '/user/signin'
  end
end

get '/user/:id/foods/new' do
  if current_user.id == params[:id].to_i
    erb :'/users/foods/new'
  else
    redirect '/user/signin'
  end
end

get '/user/:id/edit' do
  @user = current_user
  erb :'/users/edit'
end

post '/user/:id/edit' do
  @user = current_user
  if (@user.update(
    username: params[:username],
    first_name: params[:first_name],
    middle_name: params[:middle_name],
    last_name: params[:last_name],
    email: params[:email],
    birth_date: params[:birth_date],
    diagnosis_date: params[:diagnosis_date],
    height: params[:height],
    medical_history: params[:medical_history]
    ))
  redirect "/user/#{params[:id]}"
  else
    erb :'/users/edit'
  end
end

get '/user/:id/meds/new' do
  # @user = current_user
  # erb :'/medications/patient_medication'
  if current_user.id == params[:id].to_i
    erb :'/medications/new'
  else
    redirect '/user/signin'
  end
end

post '/user/:id/meds' do
  @med = Medication.find_by(name: params[:name])
  @meds = "#{params["meds"]}"
  if @med
    @patient_med = PatientMedication.new(
      name: @med.name,
      user_id: current_user.id,
      medication_id: @med.id,
      quantity: params[:quantity],
      din: params[:din],
      medication_time: params[:medication_time]
      )
    if @patient_med.save
      if params["submit_med"]
        @meds = nil
        redirect "/user/#{current_user.id}"
      elsif params["add_med"]
        @meds += "_#{@patient_med.name}_"
        @present_date_time = params[:medication_time]
        erb :'/medications/new'
      end
    else
      erb :'/medications/new'
    end
  else
    @error = "This medicine is not in our database"
    erb :'/medications/new'
  end
end

get '/user/:id/measurements/new' do
  @user = current_user
  erb :'/measurements/patient_measurement'
end

post '/user/:id/measurements' do
  @user = current_user
  params[:measurement_time] = add_date_to_time(params[:measurement_time])
  @patient_measurement = PatientMeasurement.new(
    blood_sugar_level: params[:blood_sugar_level],
    systolic_pressure: params[:systolic_pressure],
    diastolic_pressure: params[:diastolic_pressure],
    weight: params[:weight],
    user_id: params[:id],
    measurement_time: params[:measurement_time]
    )
  if @patient_measurement.save
    redirect "/user/#{params[:id]}"
  else
    erb :'/measurements/patient_measurement'
  end
end

get '/user/:id/measurements/view' do
  @user = current_user
  @measurements_arr = @user.patient_measurements.order("created_at DESC")
  erb :'/measurements/view_patient_measurement'
end

get '/user/:id/measurements/:measure_id/update' do
  @user = current_user
  @measurement = @user.patient_measurements.find(params[:measure_id])
  erb :'/measurements/update_patient_measurement'
end

post '/user/:id/measurements/:measure_id' do
  @user = current_user
  @measurement = @user.patient_measurements.find(params[:measure_id])
  if (@measurement.update(
    blood_sugar_level: params[:blood_sugar_level],
    systolic_pressure: params[:systolic_pressure],
    diastolic_pressure: params[:diastolic_pressure],
    weight: params[:weight],
    measurement_time: params[:measurement_time]
    ))
  redirect "/user/#{params[:id]}/measurements/view"
  else
    erb :"/measurements/update_patient_measurement"
  end
end
#########################
get '/user/:id/foods/view' do
  @user = current_user
  @foods_arr = @user.patient_foods.order("created_at DESC")
  erb :'/users/foods/view_patient_food'
end

get '/user/:id/foods/:food_id/update' do
  @user = current_user
  @food = @user.patient_foods.find(params[:food_id])
  erb :'/users/foods/update_patient_food'
end

post '/user/:id/foods/:food_id' do
  @user = current_user
  @db_food = Food.find_by(name: params[:name])
  @food = @user.patient_foods.find(params[:food_id])
  if (@food.update(
    name: @db_food.name,
    user_id: current_user.id,
    food_id: @db_food.id,
    measure: params[:measure],
    meal_time: params[:meal_time],
    description: params[:description]
    ))  
  redirect "/user/#{params[:id]}/foods/view"
  else
    erb :"/users/foods/update_patient_food"
  end
end
##############################
get '/user/:id/meds/view' do
  @user = current_user
  @medications_arr = @user.patient_medications.order("created_at DESC")
  erb :'/medications/view_patient_medication'
end

get '/user/:id/meds/:med_id/update' do
  @user = current_user
  @medication = @user.patient_medications.find(params[:med_id])
  erb :'/medications/update_patient_medication'
end

post '/user/:id/meds/:med_id' do
  @user = current_user
  @db_medication = Medication.find_by(name: params[:name])
  @medication = @user.patient_medications.find(params[:med_id])
  if (@medication.update(
    name: @db_medication.name,
    user_id: current_user.id,
    medication_id: @db_medication.id,
    quantity: params[:quantity],
    din: params[:din],
    medication_time: params[:medication_time]
    ))
  redirect "/user/#{params[:id]}/meds/view"
  else
    binding.pry
    erb :"/medications/update_patient_medication"
  end
end
##########################

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

post "/user/:id/foods" do
  @food = Food.find_by(name: params[:name])
  @meal = "#{params["meal"]}"
  if @food
    @patient_food = PatientFood.new(
      name: @food.name,
      user_id: current_user.id,
      food_id: @food.id,
      measure: params[:measure],
      meal_time: params[:meal_time],
      description: params[:description] 
      )
    if @patient_food.save
      if params["submit_food"]
        @meal = nil
        redirect "/user/#{current_user.id}"
      elsif params["add_food"]
        @meal += "_#{@patient_food.name}_"
        @present_date_time = params[:meal_time]
        erb :'users/foods/new'
      end
    else
      erb :'users/foods/new'
    end
  else
    @error = "This food item is not in our database"
    erb :'users/foods/new'
  end
end

get '/aboutus' do
  erb :"about"
end


###Experimental stuff
get '/user/:id/measurements/graphs' do
  @user = User.find(params[:id])
  @sugar_values = @user.extracting_measurements_for_graph("sugar_level")
  @pressure_values = @user.extracting_measurements_for_graph("pressure")
  @weight_values = @user.extracting_measurements_for_graph("weight")
  erb :'/measurements/graphs' 
end

get '/user/:id/foods/report' do
  @user = User.find(params[:id])
  @meals = @user.unify_meals_per_day
  @carbs = @user.nutrient_counter_history("carbohydrate")
  @protein = @user.nutrient_counter_history("protein")
  @sugar = @user.nutrient_counter_history("total_sugar")
  @fiber = @user.nutrient_counter_history("total_dietary_fibre")
  @fat = @user.nutrient_counter_history("total_fat")
  erb :'/users/foods/report'
end


# get '/report' do
# content_type 'application/pdf'

# pdf = Prawn::Document.new
# current_user.nutrient_counter_history("carbohydrate").each do |date,value|
# pdf.text  "On #{date} consumed #{value} carbs"
# end
# pdf.render

# end

get '/report' do
  image_link = Gchart.line_xy( :theme => :thirty7signals, 
                      :title => 'Blood sugar level',
                      :data => [[1,2,3,4,5],[10,10,20,20,30]],
                      :axis_with_labels => ['days','blood sugar level'],
                      :size => '400x400',
                      :axis_labels => [1,2,3,4,5],
                      #:legend => results.keys,
                      :encoding => 'text',
                      :max_value => 'false'
                     ).sub!('chds=,', 'chds=a')




# pdf = Prawn::Document.new
# pdf.image open([image_link,"pnj"].join("."))
# #pdf.image open("https://upload.wikimedia.org/wikipedia/en/7/7e/PGN_logo.jpg")
# pdf.render
 binding.pry
 Prawn::Document.generate("remote_images.pdf") do 
    image open(image_link)
      end
# Prawn::Document.render_file "remote_images.pdf"
end

