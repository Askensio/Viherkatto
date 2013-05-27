# encoding: UTF-8

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    Plant.create!(name: "Example Plant",
                  aestethic_appeal: 1,
                  latin_name: "Plantus Examplus",
                  coverage: 1,
                  colour: "Blue",
                  light_requirement: 1,
                  maintenance: 1,
                  min_soil_thickness: 1,
                  weight: 1,
                  note: "Totally fabulous plant")

    99.times do |n|
      name = Faker::Lorem.words(2).join(" ")
      latin_name = Faker::Lorem.words(2).join(" ")
      appeal = 1
      colour = "Green"
      maintenance = 1
      coverage = 1
      thickness = 1
      light = 1
      weight = 1
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

    Base.create!(material: "kivimurska",
                 thickness: 60,
                 weight: 100,
                 absorbancy: 30)

    99.times do |n|
      material = Faker::Lorem.words(1)
      thickness = 20
      weight = 60
      absorbancy = 100

      Base.create!(material: material,
                   thickness: thickness,
                   weight: weight,
                   absorbancy: absorbancy)
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

