namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "admin@foo.bar",
                         password: "foobar12",
                         password_confirmation: "foobar12")
    admin.toggle!(:admin)
    User.create!(name: "Example User",
                 email: "foo@bar.com",
                 password: "foobar12",
                 password_confirmation: "foobar12")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end