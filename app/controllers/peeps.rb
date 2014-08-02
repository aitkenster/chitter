post '/peeps' do 
	peep_text = params["peep_text"]
	timestamp = Time.now
	if peep_text != "" && session[:user_id] != nil
		Peep.create(:peep_text => peep_text,
								:timestamp => timestamp)
		redirect to('/')
	elsif peep_text != ""
		flash[:errors] = ["Please sign in or register to send a peep."]
	else
		flash[:errors] = ["Surely your mind isn't completely empty?"]
	end
end