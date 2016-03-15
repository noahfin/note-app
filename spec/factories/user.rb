FactoryGirl.define do  
  factory :user do
    name "Joe"
    email 'nonothetoad@gmail.com'
    password 'x1234567'
   password_confirmation 'x1234567'
  end
end  