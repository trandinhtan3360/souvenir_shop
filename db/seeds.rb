20.times do |n|
  User.create! name: "trandinhtan", email: "trandinhtan{n}@gmmail.com", password: "12345678"
end
