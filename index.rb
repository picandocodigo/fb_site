require 'sinatra'
require 'sass'
require './lib/coderwall'

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss :style
end

get '/' do
  @coderwall = CoderWall.achievements_of("picandocodigo")
  haml :home
end

get '/about' do
  @title = 'Acerca de este sitio'
  haml :about
end

get '/wordpress' do
  @title = 'Desarrollo en WordPress'
  haml :wordpress
end

get '/contact' do
  @title = "Contacto"
  haml :contact
end

post '/contact' do
  require 'pony'
  
  Pony.mail(
    # Configured for Heroku here:
    :name => params[:name],
    :mail => params[:mail],
    :body => params[:body],
    # Change contact e-mail here:
    :to => 'fernando@picandocodigo.net',
    :subject => params[:name] + ' ' + params[:mail] + " has contacted you",
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  )
  
  redirect '/success'
end

get '/success' do
  haml :success, :layout => :index
end
