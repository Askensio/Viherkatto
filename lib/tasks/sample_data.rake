# encoding: UTF-8

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do


    Light.create!(desc: "Aurinkoinen")
    Light.create!(desc: "Varjoisa")
    Light.create!(desc: "Puolivarjoisa")

    Colour.create!(value: "Keltainen")
    Colour.create!(value: "Punainen")
    Colour.create!(value: "Sininen")
    Colour.create!(value: "Vihreä")

    GrowthEnvironment.create!(environment: "Heinikko")
    GrowthEnvironment.create!(environment: "Sammalikko")
    Maintenance.create!(name: "Luonnonmukainen")
    Maintenance.create!(name: "Hieman hoitoa vaativa")
    Maintenance.create!(name: "Paljon hoitoa vaativa")

    99.times do |n|
      name = Faker::Lorem.words(4).join(" ")
      latin_name = Faker::Lorem.words(4).join(" ")
      min_height = 10
      max_height = 20
      thickness = n+8
      light = 2
      weight = n+1
      note = "asd"
      maintenance = 1

      @plant = Plant.new(name: name,
                         latin_name: latin_name,
                         height: height,
                         maintenance: maintenance,
                         min_soil_thickness: thickness,
                         weight: weight,
                         note: note)

      colour =  Colour.find_by_id n%3 + 1
      @plant.colours << colour
      colour =  Colour.find_by_id (n-1)%3 + 1
      @plant.colours << colour
      @plant.save!
      @plant.update_attributes(:light_id => light)
      @plant.update_attributes(:maintenance => Maintenance.find_by_id(maintenance))
      @plant.growth_environments << GrowthEnvironment.find(1)
    end

    Layer.create!(name: "Kivimurska",
                  product_name: "Murske 2000",
                  thickness: 60,
                  weight: 100)

    99.times do |n|
      name = Faker::Lorem.words(1).join(" ")
      product_name = Faker::Lorem.words(1).join(" ")
      thickness = n*10+1
      weight = thickness+10

      Layer.create!(name: name,
                    product_name: product_name,
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

    Environment.create!(name: "Esikaupunki")
    Environment.create!(name: "Keskusta")
    Environment.create!(name: "Maaseutu")
    Environment.create!(name: "Merenranta")
    Environment.create!(name: "Pelto")
    Environment.create!(name: "Metsä")
    Environment.create!(name: "Kaupunki")
    Environment.create!(name: "Muu")

    id = 1
    40.times do |n|
      id = id + 1
      if (id > 4)
        id = 1
      end
      area = n
      declination = n%3
      load_capacity = 10*n

      @roof = Roof.new(area: area, declination: declination, load_capacity: load_capacity)
      @roof.environments << Environment.find(id)

      @plants = [Plant.find(1), Plant.find(2)]
      @base = Base.new(absorbancy: 20)
      @layer1 = Layer.new(name: "Materiaali1", product_name: "Repan piparkakku", thickness: 30, weight: 20)
      @layer2 = Layer.new(name: "Materiaali2", product_name: "Repan mansikkakiisseli", thickness: 80, weight: 10)
      @base.layers << @layer1
      @base.layers << @layer2


      address = Faker::Lorem.words(3).join(" ")
      constructor = "Laurin viherpiperrys kommandiittiyhtiö"
      purpose = 1
      note = Faker::Lorem.words(5).join(" ")
      @user = User.find(n+1)

      @groof = Greenroof.new(address: address, constructor: constructor, purpose: purpose, note: note)
      @groof.user = @user
      @groof.roof = @roof
      @groof.plants = @plants
      @groof.bases << @base
      @groof.save
    end

    @contact = Contact.new(otsikko: "Viherkattotietokanta!", email: "viher@katto.fi", puhelin: "040-040040", note: "Testi", osoite: "Kumpula rock city")
    @contact.save

  end
end

