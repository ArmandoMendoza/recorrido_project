# README
Requerimientos:
* Ruby 2.7.2
* Rails 6.1
* Node 12
* Postgresql

Instalación:
* Ejecutar: bundle
* Ejecutar: rake yarn:install
* Configurar credenciales de BD en config/database.yml
* Ejecutar: rake db:create && rake db:migrate && rake db:seed 
* Ejecutar pruebas: rake

La app es una app rails full stack, esto significa que tiene tiene soporte ActiveView entre otros.
Existen 6 modelos:
- Company
- CompanySchedule
- Contract
- ContractSchedule
- User
- UserSchedule

Las relaciones y el modelado se detallan aqui: https://github.com/ArmandoMendoza/recorrido_project/blob/master/erd.pdf


