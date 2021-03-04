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
* Ejecutar servidores: foreman s

La app es una app rails full stack, esto significa que tiene tiene soporte ActiveView entre otros.
Existen 6 modelos:
- Company
- CompanySchedule
- Contract
- ContractSchedule
- User
- UserSchedule

Las relaciones y el modelado se detallan aqui: https://github.com/ArmandoMendoza/recorrido_project/blob/master/erd.pdf



# Breve Explicacion
Company tiene un Contract que a su vez tiene muchos ContractSchedule. En ContractSchedule se almacena la fecha de inicio y termino del contrato. En ContractSchedule se almacena la informacion de las reglas o parametros para generar el calendario completo de horas que se va a utilizar en la empresa. Los datos requeridos para ContractSchedule son day, start_hour y hours, day se refiere al dia de la semana y debe estar en ingles ("monday"), start_hour es la hora de comienzo del horario y de formato "XX:XX" usando 24H y hour es el numero total de horas asignadas para ese dia. El calendario final se genera desde la fecha de inicio hasta la fecha final del contrato, utilizando la gema IceCube https://github.com/seejohnrun/ice_cube. El calendario se genera usando el metodo #create_schedules! en la instancia de Company que se vaya a utilizar, asi mismo, es necesario generar un calendario para cada usuario que vaya estar asignado a la compañia, estos datos se almacenan en UserSchedule y es donde los usuarios almacenan tambien su disponibilidad. 

CompanySchedule y UserSchedule almacenan los datos del calendario generado usando los campos week, day, time, y block, de estos el mas relevante es block el cual es un identificador del espacio de tiempo en el calendario, el formato del campo block tiene el siguiente formato "week-dia-hora" es decir que 818 representa la semana 8 dia lunes hora 8AM. Cada block se genera por intervalos de 1H que puede ser modificado a gusto en las constantes de https://github.com/ArmandoMendoza/recorrido_project/blob/master/lib/schedule/date_rule_generator.rb

Para generar el calendario de un usuario se utiliza el metodo #create_user_schedules!(user_id) El usuario debe pertenecer a la compañia o de lo contrario se genera un error.

La disponibilidad del usuario se setea o desestea utilizando el metodo de instancia de User #set_availability!(block: XXX) y #unset_availability!(block: XXX). Donde block es valor explicado arriba y almacenado en UserSchedule.

Con respecto a los controladores y su funcionamiento recomiendo ojear los specs en: https://github.com/ArmandoMendoza/recorrido_project/tree/master/spec/requests/api

Con respecto a la asignacion de las horas del calendario, el algoritmo se desarrolla en clases dentro de la carperta https://github.com/ArmandoMendoza/recorrido_project/tree/master/lib/schedule/algorithms. Aunque estas clases estan lejos de ser Adapters, se diseñaron pensando en la escalabilidad de la app y que se puedan probar rapidamente diferentes algoritmos en tiempo de desarrollo. La implementacion de un Algoritmo se hace usando modulos en la carpeta /models/concers y cada modulo tiene los metodos necesarios para la ejecucion del algoritmo. Para usar un algoritmo solo es necesario hacer un Include de su respectivo modulo en el model Company. Actualmente hay dos algoritmos desarrollados: SimpleAssignmentAlgorithm que fue desarrollado por mi y que simplemente atraves de una busqueda asigna espacios disponibles a los usuarios sin tomar en cuenta muchas variables. Tambien esta OrToolAlgorithm que es una implementacion de la gema https://github.com/ankane/or-tools. Ambos algoritmos funcionan a su manera. Pero desarrollar un algoritmo que cumpla los requerimientos del proyecto al pie de la letra, pasa por desarrollar un algoritmo mas complejo utilizando Programacion Lineal.

La interfaz grafica esta desarrollada en VueJs y es muy simple, pero cumple con los requisitos para probar todo el sistema sin necesidad de recurrir a seeds o la consola de rails.

# TODO
Hay algunas cosas que me hubiera gustado hacer, pero por razones de tiempo quedaron pendientes.
* Implementar SideKiq para que la generacion de los CompanySchedule y UserSchedule se haga en segundo plano. Esto porque si una empresa tiene muchos usuarios y un contrato de varios años, puede aumentar el tiempo de espera drasticamente.
* Desarrollar una suite de pruebas para UI.
* Implementar Routes y Vuex en UI.






