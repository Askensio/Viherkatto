namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do


    99.times do |n|
      name = Faker::Lorem.words(2).join(" ")
      latin_name = Faker::Lorem.words(2).join(" ")
      appeal = 1
      colour = "Green"
      maintenance = 2
      coverage = 1
      thickness = n+1
      light = 2
      weight = n+1
      note = "asd"

      Plant.create!(name: name,
                    latin_name: latin_name,
                    coverage: coverage,
                    aestethic_appeal: appeal,
                    colour: colour,
                    maintenance: maintenance,
                    min_soil_thickness: thickness,
                    weight: weight,
                    light_requirement: light,
                    note: note)
    end


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
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

  end
end

