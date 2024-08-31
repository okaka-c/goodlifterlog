FactoryBot.define do
  factory :profile do
    gender { 'women' }
    birthday { Date.new(1993, 6, 30) }
  end
end
