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

user_one = User.create!(email: "tom.johnson@unbias.global",
                        password: "123456",
                        first_name: "Tom",
                        last_name: "Johnson")

user_two = User.create!(email: "anna.flemming@unbias.global",
                        password: "123456",
                        first_name: "Anna",
                        last_name: "Flemming")
user_three = User.create!(email: "javier@unbias.global",
                        password: "123456",
                        first_name: "Javier",
                        last_name: "Suay")
# user_four = User.create!(email: "anna.flemming@unbias.global",
#                         password: "123456",
#                         first_name: "Anna",
#                         last_name: "Flemming")
# user_five = User.create!(email: "anna.flemming@unbias.global",
#                         password: "123456",
#                         first_name: "Anna",
#                         last_name: "Flemming")
# user_six = User.create!(email: "anna.flemming@unbias.global",
#                         password: "123456",
#                         first_name: "Anna",
#                         last_name: "Flemming")

puts "created #{User.count} users"

puts "deleting articles"
Article.destroy_all

# puts "creating articles"

# article_one = Article.create!(
#             author: "Jon Sharman",
#             title: "Refusal to make contingency plans for schools during pandemic ‘unforgivable’, says report",
#             description: "Ministers must learn quickly from past errors before winter Covid-19 disruption, unions warn",
#             url: "https://www.independent.co.uk/news/uk/politics/covid-school-exams-b1896118.html",
#             source: "The Independent",
#             image: "https://static.independent.co.uk/2021/08/03/17/EDUCATION20AntiSemitism202007151192.jpg?width=1024&auto=webp",
#             category: "general",
#             language: "en",
#             country: "gb",
#             published_at: "2021-08-03T22:57:44+00:00")


# article_two = Article.create!(
#             author: "Mayank Aggarwal",
#             title: "Unvaccinated Americans believe vaccines are more dangerous than Covid-19, says survey",
#             description: "The survey said majority of Republicans are against wearing a mask outdoors",
#             url: "https://www.independent.co.uk/news/world/americas/americans-unvaccinated-covid-vaccine-survey-b1897222.html",
#             source: "The Independent",
#             image: "https://static.independent.co.uk/2021/08/05/09/1331502507.jpg?width=1024&auto=webp",
#             category: "general",
#             language: "en",
#             country: "gb",
#             published_at: "2021-08-05T11:02:50+00:00")

# article_three = Article.create!(
#             author: "George Bass",
#             title: "As a security guard, I can sense danger now Covid restrictions have lifted",
#             description: "If it blows up, I’ll stick to my training: don’t let people get close enough to pull your mask off, but use preventative measures before physical intervention",
#             url: "https://www.independent.co.uk/voices/covid-security-guard-university-b1895840.html",
#             source: "Independent",
#             image: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2020/12/23/20/newfile-2.jpg?width=1024&auto=webp",
#             category: "general",
#             language: "en",
#             country: "uk",
#             published_at: "2021-08-05T08:42:44+00:00")

# article_four = Article.create!(
#             author: "Shweta Sharma",
#             title: "Famed disease expert says ‘we’re closer to the beginning’ of Covid pandemic than to the end",
#             description: "Booster shots are needed ‘right away’ for elderly people as virus in their body can mutate more",
#             url: "https://www.independent.co.uk/news/world/americas/covid-pandemic-end-expert-delta-b1899846.html",
#             source: "The Independent",
#             image: "https://static.independent.co.uk/2021/08/10/05/Larry%20Brilliant.jpg?width=1024&auto=webp",
#             category: "general",
#             language: "en",
#             country: "gb",
#             published_at: "2021-08-10T07:07:23+00:00")

# article_five = Article.create!(
#             author: "Ted Hennessey",
#             title: "People pinged by app ‘four times more likely to have Covid’",
#             description: "Some 750,000 people contributed to study",
#             url: "https://www.independent.co.uk/news/health/nhs-app-pings-covid-infections-b1902191.html",
#             source: "The Independent",
#             image: "https://static.independent.co.uk/2021/08/13/14/PA-61641597.jpg?width=1024&auto=webp",
#             category: "general",
#             language: "en",
#             country: "gb",
#             published_at: "2021-08-13T14:41:29+00:00")

# article_six = Article.create!(
#             author: "George Smith",
#             title: "Biden shows he's ready to make drastic moves in Covid-19 fight -- even if he's not sure they're legal",
#             description: "Even President Joe Biden doesn't know whether his new federal eviction moratorium for renters is legal and sustainable. But crushing humanitarian and political pressure left him no choice but to take a chance on an emergency move.",
#             url: "http://rss.cnn.com/~r/rss/cnn_latest/~3/_r6dbsmXB-U/index.html",
#             source: "CNN",
#             image: "https://cdn.cnn.com/cnnnext/dam/assets/210803172644-03-biden-0803-super-169.jpg",
#             category: "general",
#             language: "en",
#             country: "us",
#             published_at: "2021-08-04T10:10:17+00:00")

# article_seven = Article.create!(
#             author: "Lisa MacGregor",
#             title: "The latest on the Covid-19 pandemic in the US",
#             description: "The Delta variant continues to accelerate its spread across the US, even as the Biden administration and CDC continue their push to get Americans vaccinated. Follow here for the latest news.",
#             url: "http://rss.cnn.com/~r/rss/cnn_latest/~3/U_a8IFM9iKc/index.html",
#             source: "CNN",
#             image: "https://cdn.cnn.com/cnnnext/dam/assets/200213175739-03-coronavirus-0213-super-169.jpg",
#             category: "general",
#             language: "en",
#             country: "us",
#             published_at: "2021-08-04T19:12:16+00:00")

# article_eight = Article.create!(
#             author: "Roy Orbinson",
#             title: "'Something very scary now is happening': Experts worry about Covid hospitalizations in the South",
#             description: "The US is averaging more than 100,000 new daily Covid-19 cases each day, the highest in nearly six months, according to data from Johns Hopkins University.",
#             url: "http://rss.cnn.com/~r/rss/cnn_topstories/~3/fjifwOWWD7s/index.html",
#             source: "CNN",
#             image: "https://cdn.cnn.com/cnnnext/dam/assets/210808005055-houston-tx-covid-testing-0804-super-169.jpg",
#             category: "general",
#             language: "en",
#             country: "us",
#             published_at: "2021-08-08T17:36:04+00:00")

# article_nine = Article.create!(
#             author: "Filip Johanson",
#             title: "I'm wearing a mask. Stop trying to shame me",
#             description: "For wearing a mask against Covid-19 in public, writes Jade Wu, \"I have been called overreactive, too covered up and way too scared,\" by friends, family, even strangers. But it's her right AND her responsiblity to stay safe and avoid potentially carrying virus into her community, she says.",
#             url: "http://rss.cnn.com/~r/rss/cnn_latest/~3/81XWQKG4xpY/index.html",
#             source: "CNN",
#             image: "https://cdn.cnn.com/cnnnext/dam/assets/210630175713-child-parent-mask-stock-super-169.jpg",
#             category: "general",
#             language: "en",
#             country: "us",
#             published_at: "2021-08-03T15:51:03+00:00")

# article_ten = Article.create!(
#             author: "Brita Erikson",
#             title: "Most seniors who died of Covid-19 lived outside nursing homes",
#             description: "As covid-19 resurges across the country, driven by the highly infectious delta variant, experts are extending our understanding of the pandemic's toll on older adults — the age group hit hardest by the pandemic.",
#             url: "http://rss.cnn.com/~r/rss/cnn_latest/~3/OvL1bv6Wh78/index.html",
#             source: "CNN",
#             image: "https://cdn.cnn.com/cnnnext/dam/assets/210310180437-05-uk-elderly-first-touch-covid-super-169.jpg",
#             category: "general",
#             language: "en",
#             country: "us",
#             published_at: "2021-08-05T15:20:57+00:00")

# puts "created #{Article.count} articles"

Source.destroy_all
puts "creating sources"

# SOURCES :

Source.create!(
                  name: "ChinaDigitalTimes",
                  source_keyword: "chinadigitaltimes",
                  address: "China"
                )
  Source.create!(
                    name: "Independent Online",
                    source_keyword: "IOL",
                    address: "South Africa"
                  )
 Source.create!(
                name: "The Journal",
                source_keyword: "thejournal",
                address: "Dublin"
                )

Source.create!(
                name: "India Times",
                source_keyword: "Indiatimes",
                address: "Mumbai, Maharastra, India"
                )

Source.create!(
                name: "Sputnik",
                source_keyword: "en",
                address: "Krasnoyarsk, Russia"
              )
Source.create!(
              name: "WAtoday",
              source_keyword: "watoday",
              address: "Perth, Australia"
              )
                  Source.create!(
                    name: "The Slovak Spectator",
                    source_keyword: "spectator",
                    address: "Bratislava, Slovakia"
                  )

                  Source.create!(
                    name: "Nigerian Tribune",
                    source_keyword: "tribune",
                    address: "Dugbe, Ibadan"
                  )
                  Source.create!(
                    name: "SunLive",
                    source_keyword: "sunlive",
                    address: "Tauranga, New Zealand"
                  )
                  Source.create!(
                    name: "Dutchnews",
                    source_keyword: "dutchnews",
                    address: "Amsterdam, Netherlands"
                  )
                  Source.create!(
                    name: "Independent",
                    source_keyword: "independent",
                    address: "Kensington, London"
                  )
                  Source.create!(
                    name: "Daily Mail",
                    source_keyword: "Mail",
                    address: "Oxford, UK"
                  )


    Source.create!(
                        name: "Manila Bulletin",
                        source_keyword: "manila-bulletin",
                        address: "Manila, Philippines"
                      )

       Source.create!(
                        name: "The Hindu",
                        source_keyword: "the-hindu",
                        address: "Chennai, India"
                        )
        Source.create!(
                    name: "Pakistan Today",
                    source_keyword: "pakistan-today",
                    address: "Pakistan"
                  )
        Source.create!(
                    name: "The Korea Herald",
                    source_keyword: "the-korea-herald",
                    address: "Seoul, Korea"
                  )
        Source.create!(
                      name: "Thailand Business News",
                      source_keyword: "thailand-business-news",
                      address: "Bangkok, Thailand"
                    )
        Source.create!(
                      name: "The Star online",
                      source_keyword: "the-star-online",
                      address: "Malaysia"
                      )
        Source.create!(
                      name: "The Japan Times",
                      source_keyword: "search",
                      address: "Tokyo, Japan"
                      )
        Source.create!(
                      name: "Jerusalem Post",
                      source_keyword: "jerusalem-post",
                      address: "Jerusalem, Israel"
                      )


# SPECIAL ONES:
   Source.create!(
                    name: "The New York Times",
                    source_keyword: "nytimes",
                    address: "New York"
                  )

        Source.create!(
                                  name: "CNN",
                                  source_keyword: "cnn",
                                  address: "Atlanta, USA"
                                  )
                    Source.create!(
                                    name: "BBC",
                                    source_keyword: "bbc",
                                    address: "London, United Kingdom"
                                    )

# STILL NOT WORKING:

# Source.create!(
#                         name: "Haaretz",
#                         source_keyword: "Haaretz - Science &amp; Health",
#                         address: "Schocken 21, Tel Aviv, Israel, 61350	Israel"
#                         )

   # Source.create!(
      #               name: "El País",
      #               source_keyword: "el-pais-english", # no
      #               address: "Madrid, Spain"
      #               )

      #  Source.create!(
      #                     name: "Chinaworker",
      #                     source_keyword: "chinaworker", # no
      #                     address: "Beijing, China"
      #                     )
# WHISLIST:
          # Source.create!(
        #                 name: "Khabar Online",
        #                 source_keyword: "????",
        #                 address: "Iran"
        #                 )

puts "Created #{Source.count} sources."

puts "have a lovely day, your friend and savior Øyvind"
