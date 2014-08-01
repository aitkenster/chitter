require 					'data_mapper'
require 					'sinatra'
require 					'rack-flash'
require_relative	'data_mapper_setup'
require_relative	'helpers/application.rb'

enable :sessions
set :session_secret, "super secret"

get '/' do 
	@peeps = Peep.all 
	erb :index
end

post '/peeps' do 
	peep_text = params["peep_text"]
	timestamp = Time.now
	Peep.create(:peep_text => peep_text,
							:timestamp => timestamp)
	redirect to('/')
end

get '/users/new' do 
	erb :"users/new"
end

post '/users' do 
	user = User.create(	name: 									params[:name],
											email:									params[:email],
											handle: 								params[:handle],
											password: 							params[:password],
											password_confirmation: 	params[:password_confirmation])
	session[:user_id] = user.id
	redirect to('/')
end 