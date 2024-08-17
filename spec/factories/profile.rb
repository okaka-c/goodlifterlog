FactoryBot.define do
  factory :profile do
    user
    gender {"man"}
    birthday { Date.new(1993, 6, 30) }
  end
end