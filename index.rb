require 'sinatra'
require 'sinatra/r18n'
require 'sass'

# Set default locale on session
before do
  if params[:locale]
    session[:locale] = params[:locale]
  else
    session[:locale] = 'en'
  end
end

get '/style.css' do
  content_type 'text/css', charset: 'utf-8'
  scss :style
end

get '/' do
  haml :home
end

get '/about' do
  haml :about
end

get '/wordpress' do
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
    name: params[:name],
    mail: params[:mail],
    from: params[:mail],
    body: params[:body],
    to: 'fernando@picandocodigo.net',
    subject: params[:name] + ' ' + params[:mail] + " has contacted you",
    via: :smtp,
    via_options: {
      address: 'smtp.sendgrid.net',
      port: '587',
      domain: 'heroku.com',
      user_name: ENV['SENDGRID_USERNAME'],
      password: ENV['SENDGRID_PASSWORD'],
      authentication: :plain,
      enable_starttls_auto: true
    }
  )
  
  redirect '/success'
end

get '/success' do
  haml :success
end
