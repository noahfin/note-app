 describe "test the dasbord" do
  before(:all) do
      user = create(:user, name: "Noah Finnerman", email: "nono@gmail.com", password: "toad123", password_confirmation: "toad123" )

  end

  it 'vists the home route and sees all post' do
  	visit  '/home'
  	expect(page).to have_content('Listing posts')
  end

   it 'displays gravatar image ' do
   	visit '/login'
    fill_in 'email_field' , with: 'nono@gmail.com'
	  fill_in 'password_field', with: "toad123"
	  click_button 'Sign in'
	  expect(page).to have_content("You are now login")

   	visit  '/home'
   	expect(page).to have_css("img[src*='gravatar.com/avatar/']")
   	
   end


end
