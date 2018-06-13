# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Coin.delete_all
Portfolio.delete_all
Holding.delete_all

3.times do
  User.create({
    email: Faker::Internet.unique.email
  })
end

Coin.create({
  name: "Bitcoin",
  ticker: "BTC"
})

Coin.create({
  name: "Ethereum",
  ticker: "ETH"
})

Coin.create({
  name: "Ripple",
  ticker: "XRP"
})

Portfolio.create(user_id: User.first.id)
Holding.create(portfolio_id: Portfolio.first.id, coin_id: Coin.first.id, quantity: 65)
Price.create(price: rand(5500..20000), coin_id: Coin.first.id, timestamp: Time.now())
