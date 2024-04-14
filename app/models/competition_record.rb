class CompetitionRecord < ApplicationRecord
  belongs_to :competition

  # スクワット 判定結果定義
  enum squat_first_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :squat_first
  enum squat_second_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :squat_second
  enum squat_third_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :squat_third
  # ベンチプレス 判定結果定義
  enum benchpress_first_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :benchpress_first
  enum benchpress_second_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :benchpress_second
  enum benchpress_third_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :benchpress_third
  # デッドリフト　判定結果定義
  enum deadlift_first_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :deadlift_first
  enum deadlift_second_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :deadlift_second
  enum deadlift_third_attempt_result: { not_attempted: 0, success: 1, failure: 2 }, _prefix: :deadlift_third


  validates :competition_id, uniqueness: true
  validates :weight, presence: true, numericality: true
  # スクワット各試技のバリテーション設定
  validates :squat_first_attempt, numericality: true, allow_nil: true
  validates :squat_second_attempt, numericality: true, allow_nil: true
  validates :squat_third_attempt, numericality: true, allow_nil: true
  # ベンチプレス各試技のバリテーション設定
  validates :benchpress_first_attempt, numericality: true, allow_nil: true
  validates :benchpress_second_attempt, numericality: true, allow_nil: true
  validates :benchpress_third_attempt, numericality: true, allow_nil: true
  # デッドリフト各試技のバリテーション設定
  validates :deadlift_first_attempt, numericality: true, allow_nil: true
  validates :deadlift_second_attempt, numericality: true, allow_nil: true
  validates :deadlift_third_attempt, numericality: true, allow_nil: true
  # スクワット試技判定結果のバリテーション設定
  validates :squat_first_attempt_result, numericality: { greater_than: 0 }, if: -> { squat_first_attempt.present? && squat_first_attempt >= 0 }
  validates :squat_second_attempt_result, numericality: { greater_than: 0 }, if: -> { squat_second_attempt.present? && squat_second_attempt >= 0 }
  validates :squat_third_attempt_result, numericality: { greater_than: 0 }, if: -> { squat_third_attempt.present? && squat_third_attempt >= 0 }
  # ベンチプレス試技判定結果のバリテーション設定
  validates :benchpress_first_attempt_result, numericality: { greater_than: 0 }, if: -> { benchpress_first_attempt.present? && benchpress_first_attempt >= 0 }
  validates :benchpress_second_attempt_result, numericality: { greater_than: 0 }, if: -> { benchpress_second_attempt.present? && benchpress_second_attempt >= 0 }
  validates :benchpress_third_attempt_result, numericality: { greater_than: 0 }, if: -> { benchpress_third_attempt.present? && benchpress_third_attempt >= 0 }
  # デッドリフト試技判定結果のバリテーション設定
  validates :deadlift_first_attempt_result, numericality: { greater_than: 0 }, if: -> { deadlift_first_attempt.present? && deadlift_first_attempt >= 0 }
  validates :deadlift_second_attempt_result, numericality: { greater_than: 0 }, if: -> { deadlift_second_attempt.present? && deadlift_second_attempt >= 0 }
  validates :deadlift_third_attempt_result, numericality: { greater_than: 0 }, if: -> { deadlift_third_attempt.present? && deadlift_third_attempt >= 0 }
end
