FactoryBot.define do
  factory :user do
    Faker::Config.locale = 'ja'
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { "1a#{Faker::Internet.password(min_length: 6)}" }
    password_confirmation { password }
    last_name             { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
    last_name_kana        { 'タナカ' }
    first_name_kana       { 'タロウ' }
    birthday              { Faker::Date.birthday }
  end
end
