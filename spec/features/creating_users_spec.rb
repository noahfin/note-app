require 'rails_helper.rb'
#http://learnaholic.me/2012/11/08/rails-app-from-scratch-user-save-and-update/

feature 'Creating users accounts' do
	def create_a_user
		visit '/'
		click_button 'Sign Up!'
		fill_in "Name", with: 'Noah'
		fill_in "Email", with: "1@example.com"
		fill_in "Password" , with: "password"
		fill_in "Password confirmation", with: "password"
		click_button 'Create Account'
		
	end
	it 'can create a user' do
		create_a_user
		expect(page).to have_content("Your account was successfuly created")
	end

	context 'not saving invalid user' do
  it 'when passwords mismatch' do
    visit '/'
		click_button 'Sign Up!'

    fill_in 'Email', with: 'xajler@gmail.com'
    fill_in 'Password', with: 'x1234567'
    fill_in 'Password confirmation', with: '55'
    fill_in 'Name', with: 'Kornelije Sajler'
    click_button 'Sign Up'
     # url = URI.parse(current_url)
    expect(current_url).to eq ("http://www.example.com/")
    # expect(page).to have_content( "Info! Passwords did not match" )
  end
end
end