
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
  ['805 Bay Meadows St.', 'Fort Wayne', 'IN', '46804'],
  ['411 Kirkland Street', 'Miami', 'FL', '33125'],
  ['870 Iroquois Drive','Marlborough', 'MA', '01752'],
  ['1 S. Cactus St.', 'Avon Lake', 'OH', '44012'],
  ['8759 Middle River Ave.', 'North Tonawanda', 'NY', '14120'],
  ['901 N. Garfield Drive' , 'Phillipsburg', 'NJ', '08865'],
  ['375 Hanover Lane', 'Hastings', 'MN', '55033'],
  ['8379 State Street', 'Calumet City', 'IL', '60409'],
  ['681 Cherry Hill Street', 'Palmetto', 'FL', '34221'],
  ['7752 Young Street', 'Erlanger', 'KY', '41018'],
  ['8099 N. Charles St.','Cambridge', 'MA', '02138'],
  ['139 Cherry St.', 'Lilburn', 'GA', '30047'],
  ['379 Wagon St.', 'Chapel Hill', 'NC', '27516'],
  ['56 Manor Ave.', 'Olney', 'MD', '20832'],
  ['455 South Blackburn Rd.', 'Media', 'PA', '19063'],
  ['7636 NE. Thatcher St.', 'Campbell', 'CA', '95008'],
  ['24 Winding Way Lane', 'Wyandotte', 'MI', '48192'],
  ['5 Eagle Drive', 'Jeffersonville', 'IN', '47130'],
  ['85 Wintergreen St.', 'Belleville', 'NJ', '07109'],
  ['7955 Nicolls Dr.', 'Somerset', 'NJ', '08873'],
  ['27 N. San Carlos Ave.', 'Soddy Daisy', 'TN', '37379'],
  ['72 Foxrun Ave.', 'Vineland', 'NJ', '08360'],
  ['17 Olive Dr.', 'Elkridge', 'MD', '21075'],
  ['845 East Lakeshore Drive', 'Wellington', 'FL', '33414'],
  ['7594 Beech Ave.', 'Morrisville', 'PA', '19067'],
  ['658 Blackburn St', 'Amarillo', 'TX', '79106'],
  ['915 Ivy Ave.', 'Amarillo', 'TX', '79106'],
  ['404 West Tower St.', 'Herndon', 'VA', '20170'],
  ['7173 Bridgeton St.', 'Clifton', 'NJ', '07011'],
  ['494 John Street', 'Avon Lake', 'OH', '44012'],
  ['998 Center Circle', 'Norwalk', 'CT', '06851'],
  ['645 Green St.', 'Beachwood', 'OH', '44122'],
  ['222 Brookside Ave.', 'Blacksburg', 'VA', '24060'],
  ['8679 Applegate Road', 'Glendora', 'CA', '91740'],
  ['920 Valley View Street', 'Charlottesville', 'VA', '22901'],
  ['75 Edgewater St.', 'Helotes', 'TX', '78023'],
  ['7487 Morris St.', 'Corpus Christi', 'TX', '78418'],
  ['12 West Grandrose Street', 'Tuscaloosa', 'AL', '35405'],
  ['3 Union St.', 'Mays Landing', 'NJ', '08330'],
  ['990 West Swanson Drive', 'Alliance', 'OH', '44601'],
  ['435 Galvin Drive', 'Sulphur', 'LA', '70663'],
  ['765 Riverview St.', 'Greensburg', 'PA', '15601'],
  ['845 Hilltop Ave.', 'Rome', 'NY', '13440'],
  ['41 East Trusel Avenue', 'Point Pleasant Beach', 'NJ', '08742'],
  ['814 San Juan Ave.', 'Cornelius', 'NC', '28031'],
  ['8912 Livingston St.', 'Schererville', 'IN', '46375'],
  ['415 Southampton Street', 'Culpeper', 'VA', '22701'],
  ['11 West Lyme Road', 'El Paso', 'TX', '79930'],
  ['524 Fremont Street', 'Schenectady', 'NY', '12302'],
  ['953 West Plumb Branch Drive', 'Quakertown', 'PA', '18951']
]

50.times do |i|

  place = addresses[i][0] + " " + addresses[i][1] + " " + addresses[i][2]
  coord = Geocoder.coordinates(place)

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
              longitude: coord[0],
              latitude: coord[1]
              )
  @physician.save

end

User.create!([
  {email: "joe@gmail.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 5, current_sign_in_at: "2016-12-02 02:17:54", last_sign_in_at: "2016-11-29 02:57:02", current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: nil, confirmed_at: nil, confirmation_sent_at: nil, unconfirmed_email: nil, avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, first_name: nil, last_name: nil, relationship: nil, phone_number: nil, admin: false},
  {email: "nathanmacaso@gmail.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 10, current_sign_in_at: "2016-12-02 02:18:08", last_sign_in_at: "2016-12-02 02:17:15", current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: nil, confirmed_at: nil, confirmation_sent_at: nil, unconfirmed_email: nil, avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, first_name: nil, last_name: nil, relationship: nil, phone_number: nil, admin: true}
])
Child.create!([
  {first_name: "Nathan", last_name: "Macaso", trisomy_type: "1", birth_date: "1982-06-19 00:00:00", death_date: nil, city: "Chicago", state: "IL", trisomy_story: "asdfasdfasdfasdf", avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, user_id: 2, private: false, nickname: nil, birth_order: nil, other_chrom_affected: nil, mosaic_percentage: nil, health_history_id: nil, background_history_id: nil, primary_diagnosis: nil, secondary_diagnosis: nil, partial_trisomy: nil, parent_id: nil, other_primary_diagnosis: nil, other_secondary_diagnosis: nil}
])
Event.create!([
  {title: "Event", description: "This is an event.", start: "2016-12-16 19:00:00", end: "2016-12-16 20:00:00", event_type: "personal", allDay: false, location: "1 N Michigan Ave. Chicago, IL"}
])
