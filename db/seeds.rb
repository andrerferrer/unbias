# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "deleting users"
User.destroy_all

puts "creating users"

User.create!(email: "tom.johnson@unbias.global",
             password: "123456",
             first_name: "Tom",
             last_name: "Johnson")

User.create!(email: "anna.flemming@unbias.global",
             password: "123456",
             first_name: "Anna",
             last_name: "flemming")

User.create!(email: "javier@unbias.global",
             password: "123456",
             first_name: "Javier",
             last_name: "Suay")

puts "created #{User.count} users"

puts "deleting articles"
Article.destroy_all

Source.destroy_all
puts "creating sources"

# SOURCES :

Source.create!(name: "ChinaDigitalTimes",
               source_keyword: "chinadigitaltimes",
               address: "China")

Source.create!(name: "Independent Online",
               source_keyword: "IOL",
               address: "South Africa")

Source.create!(name: "The Journal",
               source_keyword: "thejournal",
               address: "Dublin")

Source.create!(name: "India Times",
               source_keyword: "Indiatimes",
               address: "Mumbai, Maharastra, India")

Source.create!(name: "Sputnik",
               source_keyword: "en",
               address: "Krasnoyarsk, Russia")

Source.create!(name: "WAtoday",
               source_keyword: "watoday",
               address: "Perth, Australia")

Source.create!(name: "The Slovak Spectator",
               source_keyword: "spectator",
               address: "Bratislava, Slovakia")

Source.create!(name: "Nigerian Tribune",
               source_keyword: "tribune",
               address: "Nigeria")

Source.create!(name: "SunLive",
               source_keyword: "sunlive",
               address: "Tauranga, New Zealand")

Source.create!(name: "Dutchnews",
               source_keyword: "dutchnews",
               address: "Amsterdam, Netherlands")

Source.create!(name: "Independent",
               source_keyword: "independent",
               address: "Kensington, London")

Source.create!(name: "Daily Mail",
               source_keyword: "Mail",
               address: "Oxford, UK")

Source.create!(name: "Manila Bulletin",
               source_keyword: "manila-bulletin",
               address: "Manila, Philippines")

Source.create!(name: "The Hindu",
               source_keyword: "the-hindu",
               address: "Chennai, India")

Source.create!(name: "Pakistan Today",
               source_keyword: "pakistan-today",
               address: "Pakistan")

Source.create!(name: "The Korea Herald",
               source_keyword: "the-korea-herald",
               address: "Seoul, Korea")

Source.create!(name: "Thailand Business News",
               source_keyword: "thailand-business-news",
               address: "Bangkok, Thailand")

Source.create!(name: "The Star online",
               source_keyword: "the-star-online",
               address: "Malaysia")

Source.create!(name: "The Japan Times",
               source_keyword: "search",
               address: "Tokyo, Japan")

Source.create!(name: "Jerusalem Post",
               source_keyword: "jerusalem-post",
               address: "Jerusalem, Israel")

# SPECIAL ONES:
Source.create!(name: "The New York Times",
               source_keyword: "nytimes",
               address: "New York")

Source.create!(name: "CNN",
               source_keyword: "cnn",
               address: "Atlanta, USA",
               img: "cnn-logo.png")

Source.create!(name: "BBC",
               source_keyword: "bbc",
               address: "London, United Kingdom",
               img: "bbc-logo.png")

# STILL NOT WORKING:

# Source.create!(name: "Haaretz",
#                source_keyword: "Haaretz - Science &amp; Health",
#                address: "Israel")

# Source.create!(name: "El País",
#                source_keyword: "el-pais-english", # no
#                address: "Madrid, Spain")

#  Source.create!(name: "Chinaworker",
#                 source_keyword: "chinaworker", # no
#                 address: "Beijing, China")

# WHISLIST:

# Source.create!(name: "Khabar Online",
#                source_keyword: "????",
#                address: "Iran")

puts "Created #{Source.count} sources."

puts "have a lovely day, your friend and savior Øyvind"
