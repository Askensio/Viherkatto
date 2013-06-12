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
  end

  factory :environment do
    name 'Merenranta'
  end

  factory :plant do
    sequence(:name) { |n| "Example Plant #{n}" }
    sequence(:latin_name) { |n| "Plantus Examplus #{n}" }
    height 1
    colour "Green"
    maintenance 1
    min_soil_thickness 20
    weight 1
    note "Totally fabulous plant"
  end

  factory :greenroof do
    address "Emminkatu 1"
    constructor "Laurin viherpiperrys kommandiittiyhtiö"
    purpose 1
    note "Viherkattotiimi on hienoin"
    user { User.find(1) }
    year 1984
  end
end
