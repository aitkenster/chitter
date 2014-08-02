require 					'data_mapper'
require 					'sinatra'
require 					'rack-flash'
require 					'sinatra/partial'

require_relative	'data_mapper_setup'
require_relative	'helpers/application'
require_relative	'controllers/application'
require_relative	'controllers/peeps'
require_relative	'controllers/users'
require_relative	'controllers/sessions'

enable :sessions
set :session_secret, "super secret"
set :partial_template_engine, :erb
use Rack::Flash


