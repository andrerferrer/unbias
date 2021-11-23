# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "delete data"
User.destroy_all

puts "create users"

user_one = User.create!(email: "tom.johnson@unbias.global",
                        password: "123456",
                        first_name: "Tom",
                        last_name: "Johnson")

user_two = User.create!(email: "anna.flemming@unbias.global",
                        password: "123456",
                        first_name: "Anna",
                        last_name: "Flemming")

puts "created #{User.count} users"
