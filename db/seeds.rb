require 'faker'


company = Company.find_or_create_by!(name: "Recorrido.cl")

ernesto = company.users.find_or_create_by!(name: "Ernesto")
barbara = company.users.find_or_create_by!(name: "Bárbara")
benjamin = company.users.find_or_create_by!(name: "Benjamin")

unless company.contract
  start_date = Time.zone.today.beginning_of_week
  end_date = start_date + 1.week
  company.create_contract!(terms: "Et sed sed. Id quae qui. Pariatur autem rerum.", start_date: start_date, end_date: end_date)
end

contract = company.contract

contract.contract_schedules.find_or_create_by!(day: "monday",    start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "tuesday",   start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "wednesday", start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "thursday",  start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "friday",    start_hour: "19:00", hours: 5)
contract.contract_schedules.find_or_create_by!(day: "saturday",  start_hour: "10:00", hours: 14)
contract.contract_schedules.find_or_create_by!(day: "sunday",    start_hour: "10:00", hours: 14)

company.create_schedules!

week = Time.zone.today.strftime("%W")
#monday
benjamin.set_availability!(block: "#{week}119".to_i)
benjamin.set_availability!(block: "#{week}120".to_i)
benjamin.set_availability!(block: "#{week}121".to_i)
benjamin.set_availability!(block: "#{week}122".to_i)
benjamin.set_availability!(block: "#{week}123".to_i)

#tuesday
ernesto.set_availability!(block: "#{week}219".to_i)
ernesto.set_availability!(block: "#{week}220".to_i)
ernesto.set_availability!(block: "#{week}221".to_i)
ernesto.set_availability!(block: "#{week}222".to_i)
ernesto.set_availability!(block: "#{week}223".to_i)

barbara.set_availability!(block: "#{week}219".to_i)
barbara.set_availability!(block: "#{week}220".to_i)
barbara.set_availability!(block: "#{week}221".to_i)
barbara.set_availability!(block: "#{week}222".to_i)
barbara.set_availability!(block: "#{week}223".to_i)

benjamin.set_availability!(block: "#{week}219".to_i)
benjamin.set_availability!(block: "#{week}220".to_i)
benjamin.set_availability!(block: "#{week}221".to_i)
benjamin.set_availability!(block: "#{week}222".to_i)
benjamin.set_availability!(block: "#{week}223".to_i)


#wednesday
benjamin.set_availability!(block: "#{week}319".to_i)
benjamin.set_availability!(block: "#{week}320".to_i)
benjamin.set_availability!(block: "#{week}321".to_i)
benjamin.set_availability!(block: "#{week}322".to_i)
benjamin.set_availability!(block: "#{week}323".to_i)

barbara.set_availability!(block: "#{week}319".to_i)
barbara.set_availability!(block: "#{week}320".to_i)
barbara.set_availability!(block: "#{week}321".to_i)
barbara.set_availability!(block: "#{week}322".to_i)
barbara.set_availability!(block: "#{week}323".to_i)

#thursday
ernesto.set_availability!(block: "#{week}419".to_i)
ernesto.set_availability!(block: "#{week}420".to_i)
ernesto.set_availability!(block: "#{week}421".to_i)
ernesto.set_availability!(block: "#{week}422".to_i)
ernesto.set_availability!(block: "#{week}423".to_i)

barbara.set_availability!(block: "#{week}419".to_i)
barbara.set_availability!(block: "#{week}420".to_i)
barbara.set_availability!(block: "#{week}421".to_i)
barbara.set_availability!(block: "#{week}422".to_i)
barbara.set_availability!(block: "#{week}423".to_i)

benjamin.set_availability!(block: "#{week}419".to_i)
benjamin.set_availability!(block: "#{week}420".to_i)
benjamin.set_availability!(block: "#{week}421".to_i)
benjamin.set_availability!(block: "#{week}422".to_i)
benjamin.set_availability!(block: "#{week}423".to_i)

#Friday
ernesto.set_availability!(block: "#{week}519".to_i)
ernesto.set_availability!(block: "#{week}520".to_i)
ernesto.set_availability!(block: "#{week}521".to_i)
ernesto.set_availability!(block: "#{week}522".to_i)
ernesto.set_availability!(block: "#{week}523".to_i)

barbara.set_availability!(block: "#{week}519".to_i)
barbara.set_availability!(block: "#{week}520".to_i)
barbara.set_availability!(block: "#{week}521".to_i)
barbara.set_availability!(block: "#{week}522".to_i)
barbara.set_availability!(block: "#{week}523".to_i)

#saturday
ernesto.set_availability!(block: "#{week}610".to_i)
ernesto.set_availability!(block: "#{week}611".to_i)
ernesto.set_availability!(block: "#{week}612".to_i)
ernesto.set_availability!(block: "#{week}613".to_i)
ernesto.set_availability!(block: "#{week}614".to_i)

barbara.set_availability!(block: "#{week}618".to_i)
barbara.set_availability!(block: "#{week}619".to_i)
barbara.set_availability!(block: "#{week}620".to_i)

benjamin.set_availability!(block: "#{week}618".to_i)
benjamin.set_availability!(block: "#{week}619".to_i)
benjamin.set_availability!(block: "#{week}620".to_i)
benjamin.set_availability!(block: "#{week}621".to_i)
benjamin.set_availability!(block: "#{week}622".to_i)
benjamin.set_availability!(block: "#{week}623".to_i)

#sundat
barbara.set_availability!(block: "#{week}710".to_i)
barbara.set_availability!(block: "#{week}711".to_i)
barbara.set_availability!(block: "#{week}712".to_i)
barbara.set_availability!(block: "#{week}713".to_i)
barbara.set_availability!(block: "#{week}714".to_i)
barbara.set_availability!(block: "#{week}715".to_i)
barbara.set_availability!(block: "#{week}716".to_i)
barbara.set_availability!(block: "#{week}717".to_i)
barbara.set_availability!(block: "#{week}718".to_i)
barbara.set_availability!(block: "#{week}719".to_i)
barbara.set_availability!(block: "#{week}720".to_i)
barbara.set_availability!(block: "#{week}721".to_i)
barbara.set_availability!(block: "#{week}722".to_i)
barbara.set_availability!(block: "#{week}723".to_i)