 describe "crate a user in before(:all)" do
  before(:all) do
  user = create(:user , email: "jo@gmail.com")
  end

  it 'vists the home route and sees all post' do
  	visit  '/home'

  	expect(page).to have_content('Listing posts')
  end
end
