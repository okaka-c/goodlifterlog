class Record::BenchPress
	include ActiveModel::Model
	attr_accessor :benchpress_first_attempt,
								:benchpress_second_attempt,
								:benchpress_third_attempt,
								:benchpress_first_attempt_result,
								:benchpress_second_attempt_result,
								:benchpress_third_attempt_result
	# ベンチプレス各試技のバリテーション設定
	with_options numericality: true, allow_nil: true do
		validates :benchpress_first_attempt
		validates :benchpress_second_attempt
		validates :benchpress_third_attempt
	end
	# ベンチプレス試技判定結果のバリテーション設定
	# 空は禁止
	with_options presence: true do
		validates :benchpress_first_attempt_result
		validates :benchpress_second_attempt_result
		validates :benchpress_third_attempt_result
	end
	# 重量の入力があったら成功か、失敗か選択させる
	validate :benchpress_first_attempt_is_not_be_not_attempted
  validate :benchpress_second_attempt_is_not_be_not_attempted
  validate :benchpress_third_attempt_is_not_be_not_attempted

	private
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
end
