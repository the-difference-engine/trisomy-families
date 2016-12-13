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
