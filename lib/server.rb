require 'data_mapper'
require 'sinatra'
require 'rack-flash'

require_relative 'peep'
require_relative 'user'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")


DataMapper.finalize

DataMapper.auto_upgrade!

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
	user = User.create(name: 		params[:name],
							email:		params[:email],
							handle: 	params[:handle],
							password: params[:password])
	session[:user_id] = user.id
	redirect to('/')
end 

helpers do 
	def current_user
		@current_user ||=User.get(session[:user_id]) if session[:user_id]
	end
end