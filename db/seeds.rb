20.times do |n|
  User.create! name: "trandinhtan", email: "trandinhtan{n}@gmmail.com", password: "12345678"
end

User.create!(name:  "Tran Dinh Tan ",
             email: "admin@gmail.com",
             password: "123456789",
             password_confirmation: "123456789",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end
