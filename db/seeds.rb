# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# administer
Contributor.create!(nick_name: 'administer',
                    email: 'administer@admin.com',
                    password: 'administer',
                    password_confirmation: 'administer',
                    admin: true)

# 99 contributors
99.times do |n|
  Faker::Config.locale = :ja
  nick_name = Faker::Internet.user_name
  email = Faker::Internet.email
  password = 'password'
  Contributor.create!(nick_name: nick_name,
                      email: email,
                      password: password,
                      password_confirmation: password)
end
