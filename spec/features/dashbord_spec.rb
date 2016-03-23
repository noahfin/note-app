 describe "test the dasbord" do
      def create_user
      user = create(:user, name: "Noah Finnerman", email: "nono@gmail.com", password: "toad123", password_confirmation: "toad123" )
      end
 
  def login 
  	visit '/login'
    fill_in 'email_field' , with: 'nono@gmail.com'
	  fill_in 'password_field', with: "toad123"
	  click_button 'Sign in'

  end

  it 'vists the home route and sees all post' do
    create_user
  	login
  	visit  '/home'
  	expect(page).to have_content('Listing posts')
  end

   it 'displays gravatar image ' do
    create_user
   	login 
	  expect(page).to have_content("You are now login")
   	visit  '/home'
   	expect(page).to have_css("img[src*='gravatar.com/avatar/']")

   end

   it "only displays posts from the current_user" do
    create_user
   	login
   	expect(page).to have_content("You are now login")
   	visit  '/posts'
   	click_button 'New Post'
    fill_in 'Title' , with: 'First post'
    click_button 'Submit' #post_content
    find_button('Save') 
   	visit  '/logout'
     user_2 = create(:user, name: "Mike fooligan", email: "mike@gmail.com", password: "mike123", password_confirmation: "mike123" )
     visit '/login'
     fill_in 'email_field' , with: 'mike@gmail.com'
	   fill_in 'password_field', with: "mike123"
	   click_button 'Sign in'
   	 click_button 'New Post'
     fill_in 'Title' , with: "Mike's note"
     click_button 'Submit'
		 find_button('Save')
     visit '/home'
     expect(page).not_to have_content("First post")
   end

   it "allows a user to add a folder" do
    create_user
     login
     visit '/home'
     expect(page).to have_content("Listing posts")
      find("#folder").find("#folder-o").click
     find("#add-folder").click
     fill_in 'folder_name', with: "Ruby"
     click_button 'Add'  
     expect(page).not_to have_content("your folder was successfuly added")
   end
   it "allows a user to put note inside of folders" do 
     create_user
     login
     visit '/home'
     expect(page).to have_content("Listing posts")
      find("#folder").find("#folder-o").click
     find("#add-folder").click
     fill_in 'folder_name', with: "Ruby"
     click_button 'Add' 
     find(".fa-eye").click
     select "Ruby", :from => "folders"
     expect(page).not_to have_content("Note was successfully updated.")

 end
end
