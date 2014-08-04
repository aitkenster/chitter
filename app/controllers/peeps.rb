post '/peeps' do 
	peep_text = params["peep_text"]
	timestamp = Time.now
	if peep_text != "" && session[:user_id] != nil
		Peep.create(:peep_text 		=> peep_text,
								:timestamp 		=> timestamp,
								:user_id 			=> session[:user_id])
		redirect to('/')
	elsif peep_text != ""
		flash[:errors] = ["Please sign in or register to send a peep."]
		redirect to('/')
	else
		flash[:errors] = ["Surely your mind isn't completely empty?"]
		redirect to('/')
	end
end

post '/reply' do 
	@original_peep = Peep.first(id: params[:original_peep])
	reply_author = current_user.handle
	@original_peep.update(reply: 			 	params[:reply_text],
												reply_author: reply_author)

	redirect to ('/')
end