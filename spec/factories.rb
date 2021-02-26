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

  factory :contract_schedule do
    day { 1 }
    start_hour { "08:00" }
    hours { 8 }
    contract
  end


end