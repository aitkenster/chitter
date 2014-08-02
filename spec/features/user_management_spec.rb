require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signs up" do 

	scenario "when being logged in" do 
		expect{ sign_up }.to change(User, :count).by(1)
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
		expect {sign_up("Nicola", "na@gmail.com", "aitkenster", "awesome", "fail")}.to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do 
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up("Nicola", "na@gmail.com", "groovy_chick", "awesome", "awesome") }.to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

	scenario "with a username that is already registered" do 
		expect{ sign_up }.to change(User, :count).by(1)
		expect{ sign_up("Nicola", "na@hotmail.com", "aitkenster", "awesome", "awesome") }.to change(User, :count).by(0)
		expect(page).to have_content("This username is already taken")
	end

end

feature "user signs in" do 

	before(:each) do 
		User.create(name: 									"Nicola",
								email: 									"na@gmail.com",
								handle: 								"aitkenster",
								password: 							"awesome",
								password_confirmation: 	"awesome" )
	end

	scenario "with correct credentials" do 
		visit('/')
		expect(page).not_to have_content("Welcome back to Chitter Nicola")
		sign_in("aitkenster", "awesome")
		expect(page).to have_content("Welcome back to Chitter Nicola")
	end

	scenario "with incorrect credentials" do 
		visit('/')
		expect(page).not_to have_content("Welcome back to Chitter Nicola")
		sign_in("aitkenster", "fail")
		expect(page).to have_content("That handle or password is incorrect")
	end

end

feature "user signs out" do 

	before(:each) do 
	User.create(name: 									"Nicola",
							email: 									"na@gmail.com",
							handle: 								"aitkenster",
							password: 							"awesome",
							password_confirmation: 	"awesome" )
	end

	scenario 'while being signed in' do 
		sign_in('aitkenster', 'awesome')
		click_button "Sign Out"
		expect(page).to have_content("Goodbye!")
		expect(page).not_to have_content("Welcome back to Chitter Nicola")
	end

end