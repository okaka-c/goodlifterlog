class Competition < ApplicationRecord
  belongs_to :user
  has_one :competition_record, dependent: :destroy
  has_one :competition_result, through: :competition_record

  validates :name, presence: true, length: { maximum: 255 }
  validates :venue, length: { maximum: 255 }
  validates :date, presence: true
  validates :competition_type, presence: true
  validates :gearcategory_type, presence: true
  validates :category, presence: true
  validates :age_group, presence: true
  validates :weight_class, presence: true
  validates :participation_status, presence: true
  validate  :date_is_not_future

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

  # scopeの定義
  scope :past_competitions, ->(gearcategory_type, category, date) {
    where(
      competition_type: :official,
      participation_status: :participated,
      gearcategory_type: gearcategory_type,
      category: category
      ).where('date < ?', date)
    }


  def best_squat_weight_result(competition)
    competition&.competition_record&.competition_result&.best_squat_weight
  end

  def best_benchpress_weight_result(competition)
    competition&.competition_record&.competition_result&.best_benchpress_weight
  end

  def best_deadlift_weight_result(competition)
    competition&.competition_record&.competition_result&.best_deadlift_weight
  end

  def total_lifted_weight_result(competition)
    competition&.competition_record&.competition_result&.total_lifted_weight
  end

  def ipf_points_result(competition)
    competition&.competition_record&.competition_result&.ipf_points
  end

  def first_benchpress_result(competition)
    competition&.competition_record&.benchpress_first_attempt
  end

  def second_benchpress_result(competition)
    competition&.competition_record&.benchpress_second_attempt
  end

  def third_benchpress_result(competition)
    competition&.competition_record&.benchpress_third_attempt
  end

  def benchpress_first_attempt_failure?(competition)
    competition&.competition_record&.benchpress_first_attempt_result == "failure"
  end

  def benchpress_second_attempt_failure?(competition)
    competition&.competition_record&.benchpress_second_attempt_result == "failure"
  end

  def benchpress_third_attempt_failure?(competition)
    competition&.competition_record&.benchpress_third_attempt_result == "failure"
  end

  private

  def date_is_not_future
    if date.present? && date > Date.today
      errors.add(:date, "は本日含む過去の日付を入力してください") 
    end
  end
end
