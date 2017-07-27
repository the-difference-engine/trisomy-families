
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'as-duration'

# Clear database
Physician.delete_all
User.where.not(user_type: "admin").delete_all
User.where(user_type: nil).delete_all
admin_family = Family.find_by(user_id: User.first.id)
Family.where.not(user_id: admin_family.user_id).delete_all
Child.where.not(family_id: admin_family.id).delete_all
Parent.delete_all
Event.delete_all
Endocrine.delete_all
Height.delete_all
Weight.delete_all
BackgroundHistory.delete_all
BehavioralHealth.delete_all
CongenitalHeartDefect.delete_all
CranialFacial.delete_all
GastricSurgery.delete_all
HeadCircumference.delete_all
MotherComplication.delete_all
IntestinalIssue.delete_all
NuerologicalCondition.delete_all
ReceivedTherapy.delete_all
Hearing.delete_all
Vision.delete_all
HealthHistory.delete_all
HomePageContent.delete_all



# Create address arrays for physicians and families
trisomy_strings = ["8", "9", "13", "18", "21", "8", "9", "13", "18", "21", "11", "12", "13", "1", "13", "16", "17", "18", "19", "21", "21", "8", "23", "24"]
physician_addresses = [
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

puts "****"

family_addresses = [
  ['625 St Louis Ave.', 'West Bloomfield', 'MI', '48322', 42.554825, -83.42573310000002],
  ['4 Jefferson St.', 'Tewksbury', 'MA', '01876', 42.5973665, -71.2613648 ],
  ['9253 Circle Avenue', 'Skokie', 'IL', '60076', 42.0495459, -87.746708],
  ['8364 Green St.', 'Kaukauna', 'WI', '54130', 44.2879207, -88.272988],
  ['8867 Brickell St.', 'Minot', 'CA', '58701', 34.05930960, -117.5459288],
  ['611 Atlantic St.', 'Beltsville', 'SC', '20705', 32.785998, -79.867668],
  ['254 Greystone Drive', 'Ocean Springs', 'TX', '39564', 31.4548593, -97.2075222],
  ['59 Tanglewood Dr.', 'North Ridgeville', 'NV', '44039', 36.024956, -115.0697536],
  ['75 Brook Street ', 'Harrisonburg', 'RI', '22801', 41.8188935, -71.3978478],
  ['8996 Purple Finch Road', 'Saratoga Springs', 'MD', '12866', 47.4185956, -94.7348196],
  ['7102 North Pawnee Drive', 'Goodlettsville', 'AZ', '37072', 34.6258594, -112.3094519],
  ['93 Redwood Ave.', 'Mcdonough', 'CA', '30252', 36.715926, -119.548161],
  ['8 Purple Finch Dr.', 'Kokomo', 'MD', '46901', 39.4101842, -77.98199509],
  ['8129 Park Ave.', 'Ormond Beach', 'TX', '32174', 28.0292417, -97.53056819],
  ['775 E. Hudson St.', 'Vista', 'OH', '92083', 40.0146517, -82.9897045],
  ['485 Third Avenue', 'Atlanta', 'GA', '30303', 40.7446712, -73.9784684],
  ['9441 Fairground Ave.', 'Scotch Plains', 'WI', '07076', 44.7376812, -90.5777019],
  ['625 Sheffield Street', 'Collierville', 'CA', '38017', 34.3480549, -119.0881152],
  ['26 Griffin Street', 'Littleton', 'RI', '80123', 41.5530951, -70.6110434],
  ['375 Grand Street', 'Roy', 'NY', '84067', 40.7163027, -73.9885619]
]

# Create Physicians
50.times do |i|
  @physician = Physician.new(
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              phone_number: Faker::Company.duns_number,
              address: physician_addresses[i][0],
              city: physician_addresses[i][1],
              state: physician_addresses[i][2],
              zip_code: physician_addresses[i][3],
              website: Faker::Internet.url,
              specialty: Faker::Lorem.word,
              longitude: physician_addresses[i][4],
              latitude: physician_addresses[i][5]
              )
  @physician.save
end

primary_diagnosis = ['Full', 'Ring', 'Partial', 'Mosaic', 'Balanced Translocation', 'Unbalanced Translocation']
secondary_diagnosis = ['Deletion', 'Ring', 'Partial', 'Mosaic', 'Balanced Translocation', 'Unbalanced Translocation']
counter = 1

# 10.times do
#   Child.create([{first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, trisomy_type: rand(1..23), birth_date: Faker::Date.between(12.years.ago, 3.years.ago), death_date: Faker::Date.between(3.years.ago, Date.today), city: Faker::Address.city, state: Faker::Address.state, trisomy_story: Faker::Hipster.paragraph, user_id: User.first, nickname: Faker::Name.first_name, birth_order: rand(1..3), other_chrom_affected: rand(1..23).to_s, mosaic_percentage: rand(1..100), private: true, primary_diagnosis: primary_diagnosis.sample, secondary_diagnosis: secondary_diagnosis.sample, health_history_id: counter}])
#   counter += 1
# end
# 10.times do
#   HealthHistory.create([{chd: [true, false].sample, multiple_cardiac_surgeries: [true, false].sample, seizure_epilepsy: [true, false].sample, metabolic_syndrome: [true, false].sample, had_an_abr: [true, false].sample }])
# end

puts  "************************"
puts  "************************"
puts  "** Physicians created **"
puts  "************************"


20.times do |i|
    # Create User 1
    last_name = Faker::Name.last_name
    u1 = User.new(
      {email: Faker::Internet.email,
      encrypted_password: "$2a$11$g8QE4NANYYMjxmfx3e/jZOABkXrQUcH6GEDXSYn1ZyrO7NqE0xAte",
      reset_password_token: nil,
      reset_password_sent_at: nil,
      remember_created_at: nil,
      sign_in_count: 5,
      current_sign_in_at: "2016-12-02 02:17:54",
      last_sign_in_at: "2016-11-29 02:57:02",
      current_sign_in_ip: "::1",
      last_sign_in_ip: "::1",
      confirmation_token: nil,
      confirmed_at: nil,
      confirmation_sent_at: nil,
      unconfirmed_email: nil,
      avatar_file_name: "https://trisomy-families.s3.amazonaws.com/qejRsVmtlbnpiVuXcrWi_11529854.png",
      avatar_content_type: nil,
      avatar_file_size: nil,
      avatar_updated_at: nil,
      first_name: Faker::Name.first_name,
      last_name: last_name,
      relationship: "Father",
      phone_number: Faker::PhoneNumber.phone_number,
      address: family_addresses[i][0],
      state: family_addresses[i][2],
      city: family_addresses[i][1],
      zip_code: Faker::Address.postcode,
      latitude: family_addresses[i][5],
      longitude: family_addresses[i][4],
      family_name: last_name,
      user_type: "family"})
    u1.save!(validate: false)

    u1_family = Family.new(
      family_name: Faker::Name.last_name,
      latitude: family_addresses[i][4],
      longitude: family_addresses[i][5],
      street_address: family_addresses[i][0],
      city: family_addresses[i][1],
      state: family_addresses[i][2],
      website: "https://somewebsite.com",
      story: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non libero felis. Etiam pharetra mauris vitae condimentum molestie. Sed sed tincidunt lectus. Vivamus sollicitudin fringilla ultrices. Duis arcu est, pretium quis tortor nec, vestibulum finibus mi. Sed arcu sapien, sodales sed facilisis et, suscipit nec nisi. Proin maximus ultrices cursus. Mauris in iaculis sem, sed tincidunt mauris.
Suspendisse fringilla, orci sit amet viverra luctus, purus nulla maximus sapien, egestas tempus augue nibh at lectus. Mauris sed dignissim justo. Nam rhoncus semper pharetra. Quisque molestie blandit tellus a egestas. Sed mollis est a dui vulputate consequat. Aliquam pretium tempor egestas. Vestibulum tristique scelerisque arcu eget semper. Proin et imperdiet nisi.

Vivamus faucibus ultrices risus, eu ornare eros eleifend in. Fusce laoreet nulla sit amet justo volutpat cursus. Pellentesque tincidunt elit eget orci commodo vestibulum. Morbi eget sapien ante. Fusce fringilla massa sed massa imperdiet iaculis. Fusce non efficitur dui, sed porttitor velit. Cras non vulputate risus. Vivamus eget arcu ultricies, tincidunt nibh sed, malesuada diam. Mauris quis odio erat. Maecenas vel dapibus urna, eget gravida tortor. Pellentesque a tellus vel erat accumsan viverra feugiat ut mauris. Aliquam bibendum commodo ornare."
    )
    u1_family.save

    @child = nil
    1.times do |value|
      @child =  Child.new(
              {first_name: Faker::Name.first_name,
                last_name: last_name,
                trisomy_type: trisomy_strings[rand(trisomy_strings.length)],
                birth_date: rand(4..20).years.ago,
                death_date: rand(1..5).years.ago,
                city: u1.city,
                state: u1.state,
                trisomy_story: Faker::Lorem.paragraph(3),
                avatar_file_name: "https://trisomy-families.s3.amazonaws.com/qejRsVmtlbnpiVuXcrWi_11529854.png",
                avatar_content_type: nil,
                avatar_file_size: nil,
                avatar_updated_at: nil,
                user_id: u1.id,
                private: false,
                nickname: Faker::Name.first_name,
                birth_order: rand(1..5),
                other_chrom_affected: nil,
                mosaic_percentage: nil,
                health_history_id: nil,
                background_history_id: nil,
                primary_diagnosis: primary_diagnosis[rand(0..5)],
                secondary_diagnosis: nil,
                partial_trisomy: nil,
                parent_id: u1_family.id,
                other_primary_diagnosis: nil,
                other_secondary_diagnosis: nil,
                family_id: u1_family.id
                })
          @child.save


          @privacy = @child.build_privacy

          @privacy = Privacy.new(child_id: @child.id)
          @privacy.save

          @mother_complications = MotherComplication.new(
          none: nil,
          gestational_diabetes: true,
          preeclampsia: nil,
          rh_factor: true,
          unsure: true,
          other: "afdsfdsfd"
          )
          @mother_complications.save

          @height = Height.new(
          one_month: "11.5",
          two_month: "11.5",
          three_month: "10.0",
          four_month: "10.0"
          )
          @height.save

          @weight = Weight.new(
          one_month: "1.5",
          two_month: "1.0",
          three_month: "3.0",
          four_month: "3.0"
          )
          @weight.save

          @head_circumference = HeadCircumference.new(
          one_month: "11.5",
          two_month: "10.5",
          three_month: "10.5",
          four_month: "10.5"
          )
          @head_circumference.save

          @background_history = BackgroundHistory.new(
                weight_at_birth: "1.5",
                height_at_birth: 10,
                head_circumference_at_birth: 11,
                trisomy_relative: true,
                delivery_method: "Planned C-section",
                weight_id: @weight.id,
                height_id: @height.id,
                head_circumference_id: @head_circumference.id,
                mother_complication_id: @mother_complications.id,
                offered_c_section: "no",
                child_complication: "no",
                apgar_score: "dsafdsf",
                gestation_age: 6,
                mother_age_at_birth: 22,
                father_age_at_birth: 25,
                multiple_birth: nil,
                multiple_birth_trisomy: true,
                siblings_with_trisomy: true
          )

          @background_history.save

          @congenital_heart_defect = CongenitalHeartDefect.new(
          asd: nil,
          vsd: true,
          pda: true,
          av_canal_defect: nil,
          dorv: true,
          tof: true,
          pfo: nil,
          other: nil,
          not_applicable: nil
          )
          @congenital_heart_defect.save

          @intestinal_issue = IntestinalIssue.new()
          @intestinal_issue.save

          @gastric_surgery = GastricSurgery.new(
            repair_of_duodenal_atresia_stenosis_web: nil,
            repair_of_anal_stenosis_atresia: true,
            gastrostomy_tube_placement: nil,
            surgery_for_hirschsprung_disease: nil,
            fundoplication_nissen_wrap: nil,
            none: nil,
            other: ""
            )
          @gastric_surgery.save

          @nuerological_condition = NuerologicalCondition.new(
          unsure: true,
          brain_malformation_surgery: nil,
          cyst_surgery: nil,
          cp_surgery: nil,
          stroke_surgery: nil,
          other: "")
          @nuerological_condition.save

          @muscular_skeletal = MuscularSkeletal.new(
          atlanto_axial_instability: nil,
          cervical_spine_degeneration: nil,
          osteopenia: true,
          osteoporosis: true,
          osteopenia_surgery: true,
          osteoporosis_surgery: true
          )
          @muscular_skeletal.save

          @cranial_facial = CranialFacial.new(
          cranial_deformities: true,
          cleft_palate: true,
          cleft_lip: true
          )
          @cranial_facial.save

          @endocrine = Endocrine.new(
            hyperthyroidism: nil,
            hypothyroidism: true,
            unsure: true,
            other: ""
          )
          @endocrine.save

          @hearing = Hearing.new(
          transient: true,
          other: ""
          )
          @hearing.save

          @vision = Vision.new(
          cataract: nil,
          strabismus: true,
          )
          @vision.save

          @behavioral_health = BehavioralHealth.new(
          depression: true,
          other_diagnosis: "",
          visual_processing: true
          )
          @behavioral_health.save

          @received_therapy = ReceivedTherapy.new(
          other: ""
          )
          @received_therapy.save

          @health_history = HealthHistory.new(
            chd: true,
            chd_id: @congenital_heart_defect.id,
            offered_cardiac_surgery: "yes",
            first_cardiac_surgery_age: 6,
            first_cardiac_surgery_successful: "yes",
            multiple_cardiac_surgeries: true,
            intestinal_issues_id: @intestinal_issue.id,
            gastric_surgery_id: @gastric_surgery.id,
            seizure_epilepsy: nil,
            nuerological_condition_id: @nuerological_condition.id,
            muscular_skeletal_id: @muscular_skeletal.id,
            sleep_apnea: "no",
            cranial_facial_id: @cranial_facial.id,
            cancer: "None",
            endocrine_id: @endocrine.id,
            metabolic_syndrome: nil,
            hearing_test: "yes",
            had_an_abr: true,
            hearing_loss_or_deaf: "None",
            hearing_loss_treatment: "None",
            failed_eye_exam: "yes",
            vision_id: @vision.id,
            behavioral_health_id: @behavioral_health.id,
            in_ei: "no",
            attend_school: nil,
            home_schooled_bound: nil,
            highest_education: "Kindergarten",
            received_therapy_id: @received_therapy.id,
            clinical_trial: true,
            clinical_trial_participation: nil,
            hearing_id: @hearing.id,
            other_cancer: ""
          )
          @health_history.save
      end

    2.times do
      @father = Parent.new(
        {first_name: u1.first_name,
         last_name: u1.last_name,
         city: u1.city,
         state: u1.state,
         phone_number: u1.phone_number,
         email: u1.email,
         relationship: "Father",
         created_at: "2016-12-02 02:17:54",
         updated_at: "2016-12-02 02:17:54",
         avatar_file_name: "https://trisomy-families.s3.amazonaws.com/qejRsVmtlbnpiVuXcrWi_11529854.png",
         avatar_content_type: nil,
         avatar_file_size: nil,
         avatar_updated_at: nil,
         child_id: @child.id,
         first_name_2: Faker::Name.first_name,
         last_name_2: Faker::Name.last_name,
         city_2: Faker::Address.city,
         state_2: Faker::Address.state,
         email_2: Faker::Internet.email,
         relationship_2: "Father"
        })
        @father.save

        @mother = Parent.new(
          {first_name: Faker::Name.first_name,
           last_name: Faker::Name.last_name,
           city: Faker::Address.city,
           state: Faker::Address.state,
           phone_number: Faker::PhoneNumber.phone_number,
           email: Faker::Internet.email,
           relationship: "Mother",
           created_at: "2016-12-02 02:17:54",
           updated_at: "2016-12-02 02:17:54",
           avatar_file_name: "https://trisomy-families.s3.amazonaws.com/qejRsVmtlbnpiVuXcrWi_11529854.png",
           avatar_content_type: nil,
           avatar_file_size: nil,
           avatar_updated_at: nil,
           child_id: @child.id,
           first_name_2: Faker::Name.first_name,
           last_name_2: Faker::Name.last_name,
           city_2: Faker::Address.city,
           state_2: Faker::Address.state,
           email_2: Faker::Address.state,
           relationship_2: "Mother"
          }
          )
        @mother.save
    end
  end

puts  "************************"
puts  "*** Families created ***"
puts  "************************"

# Create events
7.times do
  num = Random.new.rand(1..20)
  @event = Event.new(
    {title: Faker::Lorem.word,
    description: Faker::Lorem.paragraph(1) ,
    start: Faker::Time.between(num.days.ago, Date.today, :morning),
    end: Faker::Time.between(num.days.ago, Date.today, :night),
    event_type: "personal",
    allDay: false,
    location: Faker::Address.street_address}
    )
  @event.save
end

puts  "************************"
puts  "**** Events created ****"
puts  "************************"
puts  "******** Done! *********"
puts  "************************"
puts  "************************"

@children = Child.all
@health_history = HealthHistory.all
@background_history = BackgroundHistory.all

20.times do |i|
  child = @children[i]
  child.health_history_id = @health_history[i].id
  child.background_history_id = @background_history[i].id
  child.save
end

HomePageContent.create(
                        banner_title: "Trisomy Families",
                        banner_text: "Bringing the community together!",
                        banner_image: "https://trisomy-families.s3.amazonaws.com/AzERgryXfTQxuwkICZRB_background-homepage.jpg",
                        mission_title: "Mission",
                        mission_sub_title: "Networking, Advocating, Supporting, and Uniting families affected by Trisomy",
                        mission_text: "What is trisomy? A trisomy is a type of polysomy in which there are three instances of a particular chromosome, instead of the normal two. Which results in a number of different congenital medical conditions.",
                        create_profile_title: "CREATE YOUR PROFILE!",
                        create_profile_text: "Signup and indicate whether you are a family or a doctor. Then build your profile page! Families can add stories and photos, as well as children, where they can provide detailed medical information, ananomously. Doctors can provide information such a practice location and specialty!",
                        family_center_title: "USE OUR FAMILY CENTER INTERACTIVE MAP!",
                        family_center_text:"When you signup, your address will be plotted on an interactive map, allowing users to find you by location, and allowing you to find them!",
                        birthday_title: "Trisomy Birthdays",
                        birthday_text: "May your birthday and every day be filled with the warmth of sunshine, the happiness of smiles, the sounds of laughter, the feeling of love and the sharing of good cheer.",
                        data_center_title: "CHECKOUT THE DATA CENTER!",
                        data_center_text: "In the Data Center, we ananomously use the information you enter about you or your family members trisomy condition to build graphs and tables that could provide further insight into this complicated medical condition",
                        company_title: "Trisomy Families",
                        company_phone_number: "555-555-5555",
                        company_address: "Cary, IL"
                        )