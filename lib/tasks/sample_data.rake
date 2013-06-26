# encoding: UTF-8

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    Role.create!(value: "Yksityishenkilö")
    Role.create!(value: "Yritys")
    Role.create!(value: "Tutkija")
    Role.create!(value: "Kunta")
    Role.create!(value: "Muu")

    Light.create!(value: "Aurinkoinen")
    Light.create!(value: "Varjoisa")
    Light.create!(value: "Puolivarjoisa")

    Colour.create!(value: "Keltainen")
    Colour.create!(value: "Punainen")
    Colour.create!(value: "Sininen")
    Colour.create!(value: "Vihreä")

    Purpose.create!(value: "Käyttökatto")
    Purpose.create!(value: "Maisemakatto")
    Purpose.create!(value: "Hyötykatto")

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
      weight = n+1
      note = "asd"

      @plant = Plant.new(name: name,
                         latin_name: latin_name,
                         min_height: min_height,
                         max_height: max_height,
                         min_soil_thickness: thickness,
                         weight: weight,
                         note: note)

      colour =  Colour.last
      @plant.colours << colour
      colour =  Colour.first
      @plant.links << Link.new(name: "eka", link: "http://eka.com")
      @plant.links << Link.new(name: "toka", link: "http://toka.com")
      @plant.links << Link.new(name: "kolmas", link: "http://kolmas.com")
      @plant.colours << colour
      @plant.light = Light.first
      @plant.maintenance = Maintenance.first
      @plant.growth_environments << GrowthEnvironment.first
      @plant.save!
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
      @roof.light = Light.first

      @plants = [Plant.find(1), Plant.find(2)]
      @base = Base.new(name: "base "+n.to_s ,absorbancy: 20, note: "this is a note")
      @layer1 = Layer.new(name: "Materiaali1", product_name: "Repan piparkakku", thickness: 30, weight: 20)
      @layer2 = Layer.new(name: "Materiaali2", product_name: "Repan mansikkakiisseli", thickness: 80, weight: 10)
      @base.layers << @layer1
      @base.layers << @layer2


      address = Faker::Lorem.words(3).join(" ")
      locality = Faker::Lorem.words(1).join(" ")
      constructor = "Laurin viherpiperrys kommandiittiyhtiö"
      @role = Role.first
      note = Faker::Lorem.words(5).join(" ")
      usage_experience = "Jee"
      owner = "Kumpulan Sorto & Riisto"
      @user = User.find(n+1)

      @groof = Greenroof.new(year: 2010, owner: owner, locality: locality, address: address, constructor: constructor, note: note, usage_experience: usage_experience)
      @groof.user = @user
      @groof.role = @role
      @groof.roof = @roof
      @groof.plants = @plants
      @groof.bases << @base
      @groof.purposes << Purpose.find(rand(2)+1)
      @groof.save!
    end

    @contact = Contact.new(otsikko: "Viherkattotietokanta!", email: "viher@katto.fi", puhelin: "040-040040", note: "Testi", osoite: "Kumpula rock city")
    @contact.save

    10.times do |n|
      base = Base.new(name: "base "+n.to_s ,absorbancy: 20, note: "this is a note")
      base.plants << Plant.first
      layer1 = Layer.new(name: "Materiaali1", product_name: "Repan piparkakku", thickness: 30, weight: 20)
      layer2 = Layer.new(name: "Materiaali2", product_name: "Repan mansikkakiisseli", thickness: 80, weight: 10)
      base.layers << layer1
      base.layers << layer2
      base.save!
    end
  end
end

