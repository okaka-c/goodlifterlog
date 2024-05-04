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
  # 空は禁止
  validates :squat_first_attempt_result, presence: true
  validates :squat_second_attempt_result, presence: true
  validates :squat_third_attempt_result, presence: true
  # 重量の入力があったら成功か、失敗か選択させる
  validate :squat_first_attempt_is_not_be_not_attempted
  validate :squat_second_attempt_is_not_be_not_attempted
  validate :squat_third_attempt_is_not_be_not_attempted
  # ベンチプレス試技判定結果のバリテーション設定
  # 空は禁止
  validates :benchpress_first_attempt_result, presence: true
  validates :benchpress_second_attempt_result, presence: true
  validates :benchpress_third_attempt_result, presence: true
  # 重量の入力があったら成功か、失敗か選択させる
  validate :benchpress_first_attempt_is_not_be_not_attempted
  validate :benchpress_second_attempt_is_not_be_not_attempted
  validate :benchpress_third_attempt_is_not_be_not_attempted
  # デッドリフト試技判定結果のバリテーション設定
  # 空は禁止
  validates :deadlift_first_attempt_result, presence: true
  validates :deadlift_second_attempt_result, presence: true
  validates :deadlift_third_attempt_result, presence: true
  # 重量の入力があったら成功か、失敗か選択させる
  validate :deadlift_first_attempt_is_not_be_not_attempted
  validate :deadlift_second_attempt_is_not_be_not_attempted
  validate :deadlift_third_attempt_is_not_be_not_attempted

  # カスタムバリデータ　スクワット判定結果
  def squat_first_attempt_is_not_be_not_attempted
    if squat_first_attempt.present? && squat_first_attempt >= 0 && squat_first_attempt_result == "not_attempted"
      errors.add(:squat_first_attempt_result, "は成功か失敗かを選んでください")
    end
  end

  def squat_second_attempt_is_not_be_not_attempted
    if squat_second_attempt.present? && squat_second_attempt >= 0 && squat_second_attempt_result == "not_attempted"
      errors.add(:squat_second_attempt_result, "は成功か失敗かを選んでください")
    end
  end

  def squat_third_attempt_is_not_be_not_attempted
    if squat_third_attempt.present? && squat_third_attempt >= 0 && squat_third_attempt_result == "not_attempted"
      errors.add(:squat_third_attempt_result, "は成功か失敗かを選んでください")
    end
  end

  # カスタムバリデータ　ベンチプレス判定結果
  def benchpress_first_attempt_is_not_be_not_attempted
    if benchpress_first_attempt.present? && benchpress_first_attempt >= 0 && benchpress_first_attempt_result == "not_attempted"
      errors.add(:benchpress_first_attempt_result, "は成功か失敗かを選んでください")
    end
  end

  def benchpress_second_attempt_is_not_be_not_attempted
    if benchpress_second_attempt.present? && benchpress_second_attempt >= 0 && benchpress_second_attempt_result == "not_attempted"
      errors.add(:benchpress_second_attempt_result, "は成功か失敗かを選んでください")
    end
  end

  def benchpress_third_attempt_is_not_be_not_attempted
    if benchpress_third_attempt.present? && benchpress_third_attempt >= 0 && benchpress_third_attempt_result == "not_attempted"
      errors.add(:benchpress_third_attempt_result, "は成功か失敗かを選んでください")
    end
  end

  # カスタムバリデータ　デッドリフト判定結果
  def deadlift_first_attempt_is_not_be_not_attempted
    if deadlift_first_attempt.present? && deadlift_first_attempt >= 0 && deadlift_first_attempt_result == "not_attempted"
      errors.add(:deadlift_first_attempt_result, "は成功か失敗かを選んでください")
    end
  end

  def deadlift_second_attempt_is_not_be_not_attempted
    if deadlift_second_attempt.present? && deadlift_second_attempt >= 0 && deadlift_second_attempt_result == "not_attempted"
      errors.add(:deadlift_second_attempt_result, "は成功か失敗かを選んでください")
    end
  end

  def deadlift_third_attempt_is_not_be_not_attempted
    if deadlift_third_attempt.present? && deadlift_third_attempt >= 0 && deadlift_third_attempt_result == "not_attempted"
      errors.add(:deadlift_third_attempt_result, "は成功か失敗かを選んでください")
    end
  end
end
