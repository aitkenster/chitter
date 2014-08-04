require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User replies to a peep" do 

	before(:each) do 
		User.create(name: 									"Nicola",
								email: 									"na@gmail.com",
								handle: 								"aitkenster",
								password: 							"awesome",
								password_confirmation: 	"awesome" )
	end

	scenario "User replies to the peep of another user" do
		sign_in("aitkenster", "awesome")
		add_peep("This is a test peep")
		visit '/'
		click_button 'Reply'
		fill_in "reply_text", with: ("This is a reply to the test peep")
		click_button "Send Reply!"
		expect(page).to have_content("aitkenster : This is a reply to the test peep")
	end

end