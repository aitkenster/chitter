require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User browses the list of links"  do
	
	before(:each) do  

		User.create(name: 									"Nicola",
								email: 									"na@gmail.com",
								handle: 								"aitkenster",
								password: 							"awesome",
								password_confirmation: 	"awesome" )

		# sign_in("aitkenster", "awesome")
		Peep.create(peep_text: "This is a test peep",
								timestamp: 	Time.now,
								user_id: 		User.first.id)

		# click_button "Sign Out"
	
	end

	scenario "When opening the home page" do 
		visit '/'
		expect(page).to have_content("This is a test peep")
	end

	xscenario 'in chronological order' do 

	end
end
