# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.destroy_all
c1 = Cat.create!(birthdate: "09/01/2009", color: "Brown", name: "Freddy", sex: "M", description: "Fluffy and shy")
c2 = Cat.create!(birthdate: "12/25/2015", color: "Black", name: "Rudolph", sex: "F", description: "Skinny and happy")
c3 = Cat.create!(birthdate: "10/31/2013", color: "Black", name: "Jason", sex: "M")

CatRentalRequest.destroy_all
r1 = CatRentalRequest.create!(cat_id: 1, start_date: "01/01/2016", end_date: "05/01/2016", status: "APPROVED")
r2 = CatRentalRequest.create!(cat_id: 2, start_date: "01/06/2016", end_date: "05/06/2016", status: "APPROVED")
r3 = CatRentalRequest.create!(cat_id: 2, start_date: "03/06/2016", end_date: "06/06/2016", status: "PENDING")
