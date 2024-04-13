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

  # 定数定義
  CATEGORIES = [ 'パワーリフティング','シングルベンチプレス' ].freeze
  AGE_GROUPS = [ '一般', 'サブジュニア', 'ジュニア', 'マスターズ1', 'マスターズ2', 'マスターズ3', 'マスターズ4', 'マスターズ5' ].freeze
  WEIGHT_CLASSES = {
    '男子' => [
      '男子59㎏級', '男子66㎏級', '男子74㎏級', '男子83㎏級', '男子93㎏級', '男子105㎏級',
      '男子120㎏級', '男子120㎏超級', '男子53㎏級(サブジュニア・ジュニア)', '男子59㎏級(サブジュニア・ジュニア)'
    ],
    '女子' => [
      '女子47㎏級', '女子52㎏級', '女子57㎏級', '女子63㎏級', '女子69㎏級', '女子76㎏級',
      '女子84㎏級', '女子84㎏超級', '女子43㎏級(サブジュニア・ジュニア)', '女子47㎏級(サブジュニア・ジュニア)'
    ]
  }.freeze

end
