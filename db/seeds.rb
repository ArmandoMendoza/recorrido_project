require 'faker'


company = Company.find_or_create_by!(name: "Recorrido.cl")

["Ernesto", "Bárbara", "Benjamin"].each do |name|
  company.users.find_or_create_by!(name: name)
end

unless company.contract
  company.create_contract!(terms: "Et sed sed. Id quae qui. Pariatur autem rerum.", start_date: Time.zone.today, end_date: (Time.zone.today + 1.week))
end

contract = company.contract

contract.contract_schedules.find_or_create_by!(day: "monday",    start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "tuesday",   start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "wednesday", start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "thursday",  start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "friday",    start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "saturday",  start_hour: "10:00", hours: 14)
contract.contract_schedules.find_or_create_by!(day: "sunday",    start_hour: "10:00", hours: 14)