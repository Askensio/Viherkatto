# encoding: UTF-8
FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    sequence(:phone) { |n| "050123453#{n}" }
    password "foobar12"
    password_confirmation "foobar12"

    factory :admin do
      admin true
    end
  end

  factory :roof do
    area '70'
    declination '1'
    load_capacity '500'
    environments { Array.new(2) { FactoryGirl.build(:environment) } }
  end

  factory :environment do
    name 'Merenranta'
  end

  factory :plant do
    sequence(:name) { |n| "Example Plant #{n}" }
    sequence(:latin_name) { |n| "Plantus Examplus #{n}" }
    min_height 1
    max_height 10
    min_soil_thickness 20
    weight 1
    note "Totally fabulous plant"
  end

  factory :greenroof do
    roof { |a| a.association(:roof) }
    user { |a| a.association(:user) }
    address "Emminkatu 1"
    constructor "Laurin viherpiperrys kommandiittiyhtiö"
    purpose 1
    note "Viherkattotiimi on hienoin"
    year 1984
    plants { Array.new(3) { FactoryGirl.build(:plant) } }

    factory :whole_greenroof do
      after(:create) do |greenroof|
        FactoryGirl.create(:base, greenroof: greenroof)
      end
    end
  end

  factory :layer do
    sequence(:name) { |n| "Kiisseli #{n}" }
    product_name "Repan kiisseli"
    thickness 10
    weight 100
  end

  factory :base do
    absorbancy 100
    note "Tämä on superlaadukas pohj-- kasvualusta."
    layers { Array.new(3) { FactoryGirl.create(:layer) }}
  end
end

