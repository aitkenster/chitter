require 'spec_helper'
require_relative 'helpers/session'

feature "User adds a new peep" do 

	before(:each) do 
	User.create(name: 									"Nicola",
							email: 									"na@gmail.com",
							handle: 								"aitkenster",
							password: 							"awesome",
							password_confirmation: 	"awesome" )
	end

	include SessionHelpers

	scenario "when browsing the homepage" do
		expect(Peep.count).to eq(0)
		visit '/'
		sign_in("aitkenster", "awesome")
		add_peep("This is a test peep")
		expect(Peep.count).to eq(1)
		peep = Peep.first
		expect(peep.peep_text).to eq("This is a test peep")
		expect(peep.user.handle).to eq("aitkenster")
	end

	def add_peep(peep_text)
		within('#new-peep') do 
			fill_in 'peep_text', with: peep_text
			click_button 'Send a Peep!'
		end
	end

	scenario "but does not add any text" do 
		expect(Peep.count).to eq(0)
		visit '/'
		sign_in("aitkenster", "awesome")
		add_peep("")
		expect(Peep.count).to eq(0)
		expect(page).to have_content("Surely your mind isn't completely empty?")
	end

	scenario "cannot add a peep if not signed in" do 
		expect(Peep.count).to eq(0)
		visit '/'
		add_peep("This is a test peep")
		expect(Peep.count).to eq(0)
		expect(page).to have_content("Please sign in or register to send a peep.")
	end

end
