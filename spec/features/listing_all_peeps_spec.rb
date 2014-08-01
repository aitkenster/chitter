require 'spec_helper'

feature "User browses the list of links"  do
	
	before (:each) {
		Peep.create(peep_text: "This is a test peep",
								timestamp: Time.now)
	}

	scenario "When opening the home page" do 
		visit '/'
		expect(page).to have_content("This is a test peep")
	end

end
