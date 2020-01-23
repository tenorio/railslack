FactoryGirl.define do
  factory :user do
    name  { FFaker::Lorem.word }
    email { FFaker::Internet.mail }
    password 'secret123'
  end
end
