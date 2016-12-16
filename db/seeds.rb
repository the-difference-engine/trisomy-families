
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'geocoder'

addresses = [
  ['805 Bay Meadows St.', 'Fort Wayne', 'IN', '46804', -85.0814343000, 41.0906369000],
  ['411 Kirkland Street', 'Miami', 'FL', '33125', -80.2480685000, 26.0605644000],
  ['870 Iroquois Drive','Marlborough', 'MA', '01752', -71.6529375000, 42.3371190000],
  ['1 S. Cactus St.', 'Avon Lake', 'OH', '44012', -82.0282001000, 41.5053178000],
  ['8759 Middle River Ave.', 'North Tonawanda', 'NY', '14120', -78.8878792000, 43.0412782000],
  ['901 N. Garfield Drive' , 'Phillipsburg', 'NJ', '08865', -75.1527038000, 40.6654305000],
  ['375 Hanover Lane', 'Hastings', 'MN', '55033', -92.8513706000, 44.7443293000],
  ['8379 State Street', 'Calumet City', 'IL', '60409', -87.6220246000, 41.6296305000],
  ['681 Cherry Hill Street', 'Palmetto', 'FL', '34221', -81.0286265000, 29.2045865000],
  ['7752 Young Street', 'Erlanger', 'KY', '41018', -84.6007773000, 39.0167275000],
  ['8099 N. Charles St.','Cambridge', 'MA', '02138', -71.0822874000, 42.3678279000],
  ['139 Cherry St.', 'Lilburn', 'GA', '30047', -84.1703014000, 33.8656634000],
  ['379 Wagon St.', 'Chapel Hill', 'NC', '27516', -78.9948532000, 35.9395443000],
  ['56 Manor Ave.', 'Olney', 'MD', '20832', -77.0472493000, 39.0736356000],
  ['455 South Blackburn Rd.', 'Media', 'PA', '19063', -75.3876930000, 39.9167783000],
  ['7636 NE. Thatcher St.', 'Campbell', 'CA', '95008', -121.9499568000, 37.2871651000],
  ['24 Winding Way Lane', 'Wyandotte', 'MI', '48192', -83.1499239000, 42.2142064000],
  ['5 Eagle Drive', 'Jeffersonville', 'IN', '47130', -85.7652072000, 38.3615476000],
  ['85 Wintergreen St.', 'Belleville', 'NJ', '07109', -74.1500469000, 40.7936744000],
  ['7955 Nicolls Dr.', 'Somerset', 'NJ', '08873', -74.3830406000, 40.6441918000],
  ['27 N. San Carlos Ave.', 'Soddy Daisy', 'TN', '37379', -85.1907904000, 35.2359025000],
  ['72 Foxrun Ave.', 'Vineland', 'NJ', '08360', -75.0259637000, 39.4863773000],
  ['17 Olive Dr.', 'Elkridge', 'MD', '21075', -76.7408149000, 39.1224483000],
  ['845 East Lakeshore Drive', 'Wellington', 'FL', '33414', -80.2136390000, 26.6521820000],
  ['7594 Beech Ave.', 'Morrisville', 'PA', '19067', -74.8738025000, 40.1946610000],
  ['658 Blackburn St', 'Amarillo', 'TX', '79106', -101.8702542000, 35.1895726000],
  ['915 Ivy Ave.', 'Amarillo', 'TX', '79106', -101.8312969000, 35.2219971000],
  ['404 West Tower St.', 'Herndon', 'VA', '20170', -77.3973801000, 38.9578476000],
  ['7173 Bridgeton St.', 'Clifton', 'NJ', '07011', -74.1637553000, 40.8584328000],
  ['494 John Street', 'Avon Lake', 'OH', '44012', -82.0282001000, 41.5053178000],
  ['998 Center Circle', 'Norwalk', 'CT', '06851', -73.4186193000, 41.1276120000],
  ['645 Green St.', 'Beachwood', 'OH', '44122', -81.5197954000, 41.5277710000],
  ['222 Brookside Ave.', 'Blacksburg', 'VA', '24060', -80.4878013000, 37.2919456000],
  ['8679 Applegate Road', 'Glendora', 'CA', '91740', -117.8653390000, 34.1361187000],
  ['920 Valley View Street', 'Charlottesville', 'VA', '22901', -78.4651152000, 38.0348438000],
  ['75 Edgewater St.', 'Helotes', 'TX', '78023', -98.6897451000, 29.5780056000],
  ['7487 Morris St.', 'Corpus Christi', 'TX', '78418', -97.4134397000, 27.7843795000],
  ['12 West Grandrose Street', 'Tuscaloosa', 'AL', '35405', -87.5691735000, 33.2098407000],
  ['3 Union St.', 'Mays Landing', 'NJ', '08330', -74.2908861000, 40.7184576000],
  ['990 West Swanson Drive', 'Alliance', 'OH', '44601', -81.1059309000, 40.9153362000],
  ['435 Galvin Drive', 'Sulphur', 'LA', '70663', -93.3773783000, 30.2365943000],
  ['765 Riverview St.', 'Greensburg', 'PA', '15601', -85.4952419000, 37.2557000000],
  ['845 Hilltop Ave.', 'Rome', 'NY', '13440', -75.2242271000, 43.1404807000],
  ['41 East Trusel Avenue', 'Point Pleasant Beach', 'NJ', '08742', -74.0479146000, 40.0912268000],
  ['814 San Juan Ave.', 'Cornelius', 'NC', '28031', -80.8600736000, 35.4868032000],
  ['8912 Livingston St.', 'Schererville', 'IN', '46375', -87.4547605000, 41.4789246000],
  ['415 Southampton Street', 'Culpeper', 'VA', '22701', -77.9300020000, 38.6562140000],
  ['11 West Lyme Road', 'El Paso', 'TX', '79930', -106.4850217000, 31.7618778000],
  ['524 Fremont Street', 'Schenectady', 'NY', '12302', -73.6606760000, 42.7962730000],
  ['953 West Plumb Branch Drive', 'Quakertown', 'PA', '18951', -75.3415667000, 40.4417682000]
]

50.times do |i|

  puts i
  puts "****"

  @physician = Physician.new(
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              phone_number: Faker::Company.duns_number,
              address: addresses[i][0],
              city: addresses[i][1],
              state: addresses[i][2],
              zip_code: addresses[i][3],
              website: Faker::Internet.url,
              speciality: Faker::Lorem.word,
              longitude: addresses[i][5],
              latitude: addresses[i][4]
              )
  @physician.save

end

u1 = User.new({email: "joe@gmail.com", encrypted_password: "$2a$11$g8QE4NANYYMjxmfx3e/jZOABkXrQUcH6GEDXSYn1ZyrO7NqE0xAte", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 5, current_sign_in_at: "2016-12-02 02:17:54", last_sign_in_at: "2016-11-29 02:57:02", current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: nil, confirmed_at: nil, confirmation_sent_at: nil, unconfirmed_email: nil, avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, first_name: nil, last_name: nil, relationship: nil, phone_number: nil, admin: false})
u1.save!(validate: false)
u2 = User.new({email: "nathanmacaso@gmail.com", encrypted_password: "$2a$11$OD5e9j4b8iLnymufmt3hTOaEUENa7p5R.phbkzm4E6PDaWo1WD4fO", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 10, current_sign_in_at: "2016-12-02 02:18:08", last_sign_in_at: "2016-12-02 02:17:15", current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: nil, confirmed_at: nil, confirmation_sent_at: nil, unconfirmed_email: nil, avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, first_name: nil, last_name: nil, relationship: nil, phone_number: nil, admin: true})
u2.save!(validate: false)

# User.create!([
#   {email: "joe@gmail.com", encrypted_password: "$2a$11$g8QE4NANYYMjxmfx3e/jZOABkXrQUcH6GEDXSYn1ZyrO7NqE0xAte", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 5, current_sign_in_at: "2016-12-02 02:17:54", last_sign_in_at: "2016-11-29 02:57:02", current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: nil, confirmed_at: nil, confirmation_sent_at: nil, unconfirmed_email: nil, avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, first_name: nil, last_name: nil, relationship: nil, phone_number: nil, admin: false},
#   {email: "nathanmacaso@gmail.com", encrypted_password: "$2a$11$OD5e9j4b8iLnymufmt3hTOaEUENa7p5R.phbkzm4E6PDaWo1WD4fO", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 10, current_sign_in_at: "2016-12-02 02:18:08", last_sign_in_at: "2016-12-02 02:17:15", current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: nil, confirmed_at: nil, confirmation_sent_at: nil, unconfirmed_email: nil, avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, first_name: nil, last_name: nil, relationship: nil, phone_number: nil, admin: true}
# ])

Child.create!([
  {first_name: "Nathan", last_name: "Macaso", trisomy_type: "1", birth_date: "1982-06-19 00:00:00", death_date: nil, city: "Chicago", state: "IL", trisomy_story: "asdfasdfasdfasdf", avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, user_id: 2, private: false, nickname: nil, birth_order: nil, other_chrom_affected: nil, mosaic_percentage: nil, health_history_id: nil, background_history_id: nil, primary_diagnosis: nil, secondary_diagnosis: nil, partial_trisomy: nil, parent_id: nil, other_primary_diagnosis: nil, other_secondary_diagnosis: nil}
])
Event.create!([
  {title: "Event", description: "This is an event.", start: "2016-12-16 19:00:00", end: "2016-12-16 20:00:00", event_type: "personal", allDay: false, location: "1 N Michigan Ave. Chicago, IL"}
])
