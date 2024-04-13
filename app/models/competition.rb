class Competition < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :venue, length: { maximum: 255 }
  validates :date, presence: true
  validates :competition_type, presence: true
  validates :gearcategory_type, presence: true
  validates :category, presence: true
  validates :age_group, presence: true
  validates :weight_class, presence: true
  validates :participation_status, presence: true

  # enum定義
  enum competition_type: { official: 0, unofficial: 1 } # 大会種別：公式大会、非公式大会
  enum gearcategory_type: { raw: 0, equipped: 1 } # ギア有無: ギア無し(raw), ギア有(equipped)
  enum participation_status: { participated: 0, scheduled: 1 } # 出場予定: 出場済、出場予定。本リリース後の大会出場予定記録で使う定義
end
