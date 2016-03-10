require 'rails_helper.rb'

feature 'Creating users' do
	it 'can create a user' do
		visit '/'
		click_button 'Sign Up!'
		fill_in "Name", with: 'Noah'
		fill_in "Email", with: "1@example.com"
		fill_in "Password" , with: "password"
		fill_in "Password confirmation", with: "password"
		click_button 'Create Account'
		expect(page).to have_content("Your account was successfuly created")
	end
end