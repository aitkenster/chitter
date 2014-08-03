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

		Peep.create(peep_text: "This is a test peep",
								timestamp: 	Time.now,
								user_id: 		User.first.id)	
	end

	scenario "When opening the home page" do 
		visit '/'
		expect(page).to have_content("Nicola(aitkenster) : This is a test peep")
	end

	scenario 'by most recent posted' do 
		Peep.create(peep_text: "This is a second test peep",
								timestamp: 	Time.now + 3600,
								user_id: 		User.first.id)
		visit '/'
		expect(page).to have_content("This is a second test peep")
		page.should have_selector("ul#peeps li:nth-child(1)", text: "This is a second test peep")
	end
end
