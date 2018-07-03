require 'factory_bot_rails'

FactoryBot.define do

  factory :user do
    email "test@email.com"
    password "Password123"
    password_confirmation "Password123"
  end

end
