Category.delete_all
Category.create! id: 1
Category.create! id: 2

Shop.delete_all
Shop.create! id:1
Shop.create! id:2

User.delete_all
User.create! id:1
User.create! id:2

Product.delete_all
Product.create! id: 1, name: "Banana", description: "trandinhtan", quantity: 123456, price: 1254
Product.create! id: 2, name: "Banana123", description: "trandinhtan123", quantity: 1123456, price: 1254321

Order.delete_all
Order.create! id: 1, receiver_name: "trandinhtan", receiver_address: "Binh Dinh", receiver_phone: "01644511926"
