require 'data_mapper'
require 'sinatra'

require_relative 'peep'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")


DataMapper.finalize

DataMapper.auto_upgrade!

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