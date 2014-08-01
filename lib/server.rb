require 'data_mapper'
require 'sinatra'

require_relative 'peep'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require 'peep'

DataMapper.finalize

DataMapper.auto_upgrade!