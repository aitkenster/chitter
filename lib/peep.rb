class Peep
	
	include DataMapper::Resource

	property :id, Serial
	property :peep_text, String
	property :timestamp, DateTime

end