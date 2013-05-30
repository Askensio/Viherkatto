# encoding: UTF-8

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do


    Light.create!(desc: "Varjoisa")
    Light.create!(desc: "Puolivarjoisa")
    Light.create!(desc: "Aurinkoinen")

    99.times do |n|
      name = Faker::Lorem.words(4).join(" ")
      latin_name = Faker::Lorem.words(4).join(" ")
      colour = "Green"
      maintenance = 2
      coverage = 1
      thickness = n+1
      light = 2
      weight = n+1
      note = "asd"

      @plant = Plant.create!(name: name,
                    latin_name: latin_name,
                    coverage: coverage,
                    colour: colour,
                    maintenance: maintenance,
                    min_soil_thickness: thickness,
                    weight: weight,
                    note: note)
       @plant.update_attribute(:light_id, light)

    end

    Layer.create!(name: "Kivimurska",
                 thickness: 60,
                 weight: 100)

    99.times do |n|
      name = Faker::Lorem.words(1).join(" ")
      thickness = n*10
      weight = thickness+10

      Layer.create!(name: name,
                   thickness: thickness,
                   weight: weight)
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

    Environment.create!(name: "Merenranta")
    Environment.create!(name: "Pelto")
    Environment.create!(name: "Metsä")
    Environment.create!(name: "Kaupunki")
    Environment.create!(name: "Muu")

    id = 1
    20.times do |n|
      id = id + 1
      if(id > 4)
        id = 1
      end
      area = n
      declination = n
      load_capacity = 10*n

      @roof = Roof.new(area: area, declination: declination, load_capacity: load_capacity)
      @roof.environments << Environment.find(id)
      @roof.save
    end

  end
end

