post '/peeps' do 
	peep_text = params["peep_text"]
	timestamp = Time.now
	if peep_text != ""
		Peep.create(:peep_text => peep_text,
								:timestamp => timestamp)
		redirect to('/')
	else
		flash[:errors] = ["Surely your mind isn't completely empty?"]
	end
end