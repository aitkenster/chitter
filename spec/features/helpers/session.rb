module SessionHelpers

	def sign_in(handle, password)
		visit('sessions/new')
		fill_in "handle", 	with: handle
		fill_in "password", with: password
		click_button "Sign In"
	end

	def add_peep(peep_text)
		within('#new-peep') do 
			fill_in 'peep_text', with: peep_text
			click_button 'Send a Peep!'
		end
	end
	
end