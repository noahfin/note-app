require 'rails_helper.rb'
#http://learnaholic.me/2012/11/08/rails-app-from-scratch-user-save-and-update/

feature 'Creating users accounts' do
	def create_a_user
		visit '/'
		click_button 'Sign Up!'
		fill_in "name_create", with: 'Noah'
		fill_in "email_create", with: "1@example.com"
		fill_in "password_create" , with: "password"
		fill_in "confirm_password_create", with: "password"
		click_button 'Create Account'
		
	end
	it 'can create a user' do
		create_a_user
		expect(page).to have_content("Your account was successfuly created")
	end
 end

	feature 'not saving invalid user' do
  it 'when passwords mismatch' do
    visit '/'
		click_button 'Sign Up!'

    fill_in 'email_create', with: 'xajler@gmail.com'
    fill_in 'password_create', with: 'x1234567'
    fill_in 'confirm_password_create', with: '55'
    fill_in 'name_create', with: 'Kornelije Sajler'
    click_button 'Create Account'
     # url = URI.parse(current_url)
    expect(current_url).to eq ("http://www.example.com/")
     expect(page).to have_content( "Info! Password confirmation doesn't match Password" )
  end

  it 'wont let a user siginup when their email is blank'do 
	  visit '/'
	  fill_in 'name_create', with: 'Becky'
	  fill_in 'email_create' , with: ' '
	  fill_in 'password_create', with: "12345678"
	  fill_in 'confirm_password_create', with: '12345678'
	  click_button 'Create Account'
	  expect(current_url).to eq ("http://www.example.com/")
    expect(page).to have_content( "Email can't be blank" )
	end

  it 'wont let a user siginup when their password is blank'do 
	  visit '/'
	  fill_in 'name_create', with: 'Becky'
	  fill_in 'email_create' , with: 'jojothecode@gmail.com'
	  fill_in 'password_create', with: ""
	  fill_in 'confirm_password_create', with: 'z2123593'
	  click_button 'Create Account'
	  expect(current_url).to eq ("http://www.example.com/")
    expect(page).to have_content( "Password can't be blank" )
	end

	it 'wont let a user siginup when their name is blank'do 
	  visit '/'
	  fill_in 'name_create', with: ''
	  fill_in 'email_create' , with: 'jojothecode@gmail.com'
	  fill_in 'password_create', with: "z2123593"
	  fill_in 'confirm_password_create', with: 'z2123593'
	  click_button 'Create Account'
	  expect(current_url).to eq ("http://www.example.com/")
    expect(page).to have_content( "Name can't be blank" )
	end
 
  scenario "can't signup when email is not unique" do
    user = FactoryGirl.create(:user, name: "Noah Finnerman", email: "nono@gmail.com", password: "toad123", password_confirmation: "toad123" )
      visit '/'
	  fill_in 'name_create', with: 'nono'
	  fill_in 'email_create' , with: 'nono@gmail.com'
	  fill_in 'password_create', with: "z2123593"
	  fill_in 'confirm_password_create', with: 'z2123593'
	  click_button 'Create Account'
	  expect(page).to have_content('Email has already been taken')
  end
  it 'displays a message when name is too short'do 
	  visit '/'
	  fill_in 'name_create', with: 'Joe'
	  fill_in 'email_create' , with: 'jojothecode@gmail.com'
	  fill_in 'password_create', with: "z2"
	  fill_in 'confirm_password_create', with: 'z2'
	  click_button 'Create Account'
	  expect(current_url).to eq ("http://www.example.com/")
    expect(page).to have_content( "Password is too short (minimum is 6 characters)" )
	end
	scenario "Wont let a user edit an account if they are not signin" do
    visit '/logout'
    click_link 'Settings'
    find('#edit-account', :text => 'Edit Account').click
	  fill_in 'name_edit', with: 'nono'
	  fill_in 'email_edit' , with: 'nono@gmail.com'
	  fill_in 'password_edit', with: "z2123593"
	  fill_in 'confirm_password_edit', with: 'z2123593'
	  click_button 'Update'
	  expect(current_url).to eq ("http://www.example.com/login")
    expect(page).to have_content( "You need to signin first" )
  end
  scenario "valid user update" do
    user = FactoryGirl.create(:user, name: "Noah Finnerman", email: "nono@gmail.com", password: "toad123", password_confirmation: "toad123" )
    visit '/login'
    fill_in 'email_field' , with: 'nono@gmail.com'
	  fill_in 'password_field', with: "toad123"
	  click_button 'Sign in'
    find('#edit-account', :text => 'Edit Account').click
    # find_field('email_edit').value.should == ('nono@gmail.com')
    # find_field('name_edit').value.should == ('Noah Finnerman')
	  fill_in 'name_edit', with: 'nono'
	  fill_in 'email_edit' , with: 'nono@gmail.com'
	  fill_in 'password_edit', with: "z2123593"
	  fill_in 'confirm_password_edit', with: 'z2123593'
	  click_button 'Update'
	   expect(page).to have_content( 'Info! Your account was successfully updated')
  end
  scenario "displays name and eamil when editing account" do
    user = FactoryGirl.create(:user, name: "Noah Finnerman", email: "nono@gmail.com", password: "toad123", password_confirmation: "toad123" )
    visit '/login'
    fill_in 'email_field' , with: 'nono@gmail.com'
	  fill_in 'password_field', with: "toad123"
	  click_button 'Sign in'
    find('#edit-account', :text => 'Edit Account').click
    expect(find("#email_edit", :visible => true).value).to eq 'nono@gmail.com'
    expect(find("#name_edit", :visible => true).value).to eq 'Noah Finnerman' 
	
  end
  scenario "user is not able to change their email" do
    user = FactoryGirl.create(:user, name: "Noah Finnerman", email: "nono@gmail.com", password: "toad123", password_confirmation: "toad123" )
    visit '/login'
    fill_in 'email_field' , with: 'nono@gmail.com'
	  fill_in 'password_field', with: "toad123"
	  click_button 'Sign in'
    find('#edit-account', :text => 'Edit Account').click

	  fill_in 'name_edit', with: 'nono'
	  fill_in 'email_edit' , with: 'yoyo@gmail.com'
	  fill_in 'password_edit', with: "z2123593"
	  fill_in 'confirm_password_edit', with: 'z2123593'
	  click_button 'Update'
	  expect(page).to have_content( 'Info! Your account was successfully updated')

	   find('#edit-account', :text => 'Edit Account').click
	   expect(find("#email_edit", :visible => true).value).to eq 'nono@gmail.com'
     expect(find("#name_edit", :visible => true).value).to eq 'nono'
   end 
   scenario "user recives a message when they login" do
    user = FactoryGirl.create(:user, name: "Noah Finnerman", email: "nono@gmail.com", password: "toad123", password_confirmation: "toad123" )
    visit '/login'
    fill_in 'email_field' , with: 'nono@gmail.com'
	  fill_in 'password_field', with: "toad123"
	  click_button 'Sign in'
	  expect(page).to have_content("You are now login")
	end
	scenario "user recives a message when they login" do
    user = FactoryGirl.create(:user, name: "Noah Finnerman", email: "nono@gmail.com", password: "toad123", password_confirmation: "toad123" )
    visit '/login'
    fill_in 'email_field' , with: 'nono@gmail.com'
	  fill_in 'password_field', with: "toad123"
	  click_button 'Sign in'
	  click_link 'Settings'
    find('#logout', :text => 'logout').click
	  expect(page).to have_content("You are now logout")
	end
end