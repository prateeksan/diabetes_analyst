# FreshPulse

Built by @edumonteiro, @fantasticjimmy, @prateeksan

>FreshPulse is an app built to make life a little easier for diabetes patients. It offers an interactive and robust way to record meals, medications and medical readings. Furthermore, it uses this data to monitor BMI and nutritional intakes, make dietary recommendations and generate reports which may be equally useful for the patient and his or her doctor. 

### Tech-Stack

1. __Server-Side__: _Ruby -v 2.2.3_, Sinatra (Sinatra-Contrib, Sintra-ActiveRecord, Sintra-Partial), Rake, ActiveSupport, Faker, Prawn, Puma, Tux, Google Charts.
2. __Client-Side__: HTML/CSS, Normalize CSS, Bootstrap, Font-Awesome, Javascript, JQuery, ChartJS, ClassieJS

### Demo

__Important Note__: FreshPulse's current deployment is for demonstration purposes only. Please do not use this site for any other purposes. It has __not__ been built or verified by medical professionals and none of its content should be treated as a credible source of information or advice. If you visit our site to test it's features, please keep the aforementioned in mind and treat it as nothing more than an experimental model.

[Click Here](http://freshpulse.herokuapp.com/)  to visit the site.

+ Username: test0
+ Password: 1234

### Features

Following are a few of FreshPulse's nifty features:

+ Maintain an up-to-date profile with medical history and other important details.
+ Track all meals and medications with a robust entry logging system.
+ Record blood pressure and blood sugar levels daily.
+ Access automatically generated analytics and interactive reports based on previous entries.
+ Receive daily nutritional recommendations based on BMI calculations, recent meals and other relevant factors. 
+ All this and more in a clean and compact user-interface!

### Screenshots

#### Log In Screen

User authentication and encryption architecture built using BCrypt. The app maintains sessions for previously authenticated users. 
![Signin](https://s3.amazonaws.com/freshpulse/readme_images/1_signin.jpg)

#### Sign Up Page

Form fields contain server-side validations to ensure all important information is submitted in proper format.
![Signup](https://s3.amazonaws.com/freshpulse/readme_images/2_signup.jpg)

#### Dashboard

The user's personalized dashboard is accessible upon login. It links to all other components of the app and displays important information about daily nutritional intake, BMI measurements, and dietary recommendations.
![Signin](https://s3.amazonaws.com/freshpulse/readme_images/3_dashboard.jpg)

#### Meal Reports

A breakdown of daily nutritional intake along with a list of all foods consumed per day and the total calorific consumption. 
![Signup](https://s3.amazonaws.com/freshpulse/readme_images/4_meal_reports.jpg)

#### New Entry Forms

Forms for recording meals, medications, blood pressure readings, and blood sugar level readings. The form displayed below is for recording medications. FreshPulse comes loaded with a database of **every single medicine legally registered in Canada as of February 2016**, along with its Drug Identification Number. This database is integrated with the autocomplete feature of the input field for new medicines. The Drug Identification Number is updated automatically and can be shown to a doctor or pharmacist for precise drug identification (A similar database is also integrated for food items and their estimated nutritional value).
![Signup](https://s3.amazonaws.com/freshpulse/readme_images/5_autocomplete.jpg)

#### Entry Logs

Automatically generated logs for all recorded meals, medications and readings in the user's recent history. All logs are categorized by date and ordered by time of consumption/reading. A user can edit previous entries recorded in the logs. 
![Signup](https://s3.amazonaws.com/freshpulse/readme_images/6_foods_index.jpg)

#### Readings Report

A patient-friendly and doctor-friendly report containing the user's blood pressure readings, blood sugar levels and weight readings in interactive graphs. This page also contains other important analytics computed by the app including the average, highest and lowest readings for each of the aforementioned parameters.
![Signup](https://s3.amazonaws.com/freshpulse/readme_images/7_readings.jpg)