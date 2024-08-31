# frozen_string_literal: true

FactoryBot.define do
  factory :competition do
    name { 'テスト大会' }
    venue { 'テスト会場' }
    date { Date.new(2024, 6, 30) }
    competition_type { 'official' }
    gearcategory_type { 'raw' }
    category { 'パワーリフティング' }
    age_group { '一般' }
    weight_class { '女子47㎏級' }
    participation_status { 'participated' }
    user
  end
end
