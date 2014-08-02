module SessionHelpers

	def sign_in(handle, password)
		visit('sessions/new')
		fill_in "handle", 	with: handle
		fill_in "password", with: password
		click_button "Sign In"
	end

end