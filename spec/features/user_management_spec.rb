require 'spec_helper'

feature "User signs up" do 

	scenario "when being logged in" do 
		lambda { sign_up }.should change(User, :count).by(1)
		expect(page).to have_content("Welcome back to Chitter Nicola")
		expect(User.first.name).to eq("Nicola")
		expect(User.first.email).to eq("na@gmail.com")
		expect(User.first.handle).to eq("aitkenster")
	end

	def sign_up(name 									= "Nicola",
							email 								= "na@gmail.com",
							handle 								= "aitkenster",
							password 							= "awesome",
							password_confirmation = "awesome")
		visit '/users/new'
		expect(page.status_code).to eq(200)
		fill_in :name, 									with: name
		fill_in :email, 								with: email
		fill_in :handle,								with: handle
		fill_in :password,							with: password
		fill_in :password_confirmation, with: password_confirmation
		click_button "Sign up"
	end

	scenario "with a password that doesn't match" do 
		lambda {sign_up("Nicola", "na@gmail.com", "aitkenster", "awesome", "fail")}.should change(User, :count).by(0)
	end

end