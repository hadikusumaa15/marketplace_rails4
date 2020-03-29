FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
  end
end
# User.create(email: 'thefun@mailowe.com', password: '1234abcdwkwk', password_confirmation: '1234abcdwkwk')