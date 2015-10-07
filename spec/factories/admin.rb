FactoryGirl.define do
factory :LibraryMember do |f|
  f.first_name { Faker::Name.first_name }
  f.Last_name { Faker::Name.last_name }
  f.email {"viswaraavi@yahoo.in"}
  f.password {Faker::Internet.password}
end
end