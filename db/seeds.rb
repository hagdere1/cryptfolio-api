# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Coin.delete_all
Portfolio.delete_all
Holding.delete_all
Address.delete_all

if User.count == 0
  User.create([{
    email: "hgagdere@gmail.com",
    password: "Password123",
    password_confirmation: "Password123"
  },
  {
    email: "aagdere@gmail.com",
    password: "Password123",
    password_confirmation: "Password123"
  }])
end

Coin.create([{
  name: "Bitcoin",
  ticker: "BTC"
},
{
  name: "Ethereum",
  ticker: "ETH"
},
{
  name: "Ripple",
  ticker: "XRP"
}])

Portfolio.create(user_id: User.first.id)

Address.create([
  {is_user: true, address: "0x5411a78d08817906d2320b90ec5f3367a597a42a", creator_id: User.first.id},
  {is_user: false, address: "0x47A7467a5cc48105d985f2C8045FbE36323AF073", creator_id: User.first.id}
])

3.times do
  Price.create([
    {price: rand(5500..20000), coin_id: Coin.find_by(ticker: "BTC").id, timestamp: Time.now()},
    {price: rand(200..1500), coin_id: Coin.find_by(ticker: "ETH").id, timestamp: Time.now()},
    {price: rand(0.20..4.2), coin_id: Coin.find_by(ticker: "XRP").id, timestamp: Time.now()}
  ])
end
