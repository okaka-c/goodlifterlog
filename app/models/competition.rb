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
  enum category: { powerlifting: 0, single_bench_press: 1 } # 競技主別: パワーリフティング,シングルベンチ
  # 年齢区分
  enum age_group: {
    open: 0,
    sub_junior: 1,
    junior: 2,
    masters_1: 3,
    masters_2: 4,
    masters_3: 5,
    masters_4: 6,
    masters_5: 7
  }
  # 階級区分
  enum weight_class: {
    men_59kg: 0,
    men_66kg: 1,
    men_74kg: 2,
    men_83kg: 3,
    men_93kg: 4,
    men_105kg: 5,
    men_120kg: 6,
    men_120kg_plus: 7,
    men_junior_53kg: 8,
    men_junior_59kg: 9,
    women_47kg: 10,
    women_52kg: 11,
    women_57kg: 12,
    women_63kg: 13,
    women_69kg: 14,
    women_76kg: 15,
    women_84kg: 16,
    women_84kg_plus: 17,
    women_junior_43kg: 18,
    women_junior_47kg: 19
  }
  # 出場予定: 出場済、出場予定。本リリース後の大会出場予定記録で使う定義
  enum participation_status: { participated: 0, scheduled: 1 }
end
