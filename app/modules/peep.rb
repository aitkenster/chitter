class Peep
	
	include DataMapper::Resource

	property 		:id, Serial
	property 		:peep_text, String
	property 		:timestamp, DateTime
	property		:reply, String
	property		:reply_author, String

	belongs_to  :user

end