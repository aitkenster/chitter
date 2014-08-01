require 					'data_mapper'
require 					'sinatra'
require 					'rack-flash'

require_relative	'data_mapper_setup'
require_relative	'helpers/application.rb'

enable :sessions
set :session_secret, "super secret"
use Rack::Flash


get '/' do 
	@peeps = Peep.all 
	erb :index
end

post '/peeps' do 
	peep_text = params["peep_text"]
	timestamp = Time.now
	if peep_text != ""
		Peep.create(:peep_text => peep_text,
								:timestamp => timestamp)
		redirect to('/')
	else
		flash[:errors] = "Surely your mind isn't completely empty?"
	end
end

get '/users/new' do 
	@user = User.new
	erb :"users/new"
end

post '/users' do 
	@user = User.new(	name: 									params[:name],
										email:									params[:email],
										handle: 								params[:handle],
										password: 							params[:password],
										password_confirmation: 	params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end 