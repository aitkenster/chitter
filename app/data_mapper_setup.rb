env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/chitter_#{env}")

require_relative 'modules/peep'
require_relative 'modules/user'

DataMapper.finalize
