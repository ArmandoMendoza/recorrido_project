require 'faker'

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
  end

  factory :user do
    name { Faker::Name.name  }
    company
  end

  factory :contract do
    terms { Faker::Lorem.paragraph }
    company
  end


end