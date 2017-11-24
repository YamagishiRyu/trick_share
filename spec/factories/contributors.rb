require 'faker'

FactoryGirl.define do
  factory :contributor do
    sequence(:email) { Faker::Internet.email }
    nick_name { Faker::Internet.user_name }
    password_string = Faker::Internet.password(7, 10)
    password { password_string }
    password_confirmation { password_string }

    initialize_with { Contributor.find_or_create_by(email: :email) }
  end

  factory :invalid_contributor, parent: :contributor do
    password_confirmation = " "
  end
end
