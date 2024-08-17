FactoryBot.define do
  factory :profile do
    gender {"man"}
    birthday { Date.new(1993, 6, 30) }
  end
end