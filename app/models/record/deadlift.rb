class Record::Deadlift
  include ActiveModel::Model
	attr_accessor :deadlift_first_attempt,
								:deadlift_second_attempt,
								:deadlift_third_attempt,
								:deadlift_first_attempt_result,
								:deadlift_second_attempt_result,
								:deadlift_third_attempt_result
	# スクワット各試技のバリテーション設定
	with_options numericality: true, allow_nil: true do
		validates :deadlift_first_attempt
		validates :deadlift_second_attempt
		validates :deadlift_third_attempt
	end
	# スクワット試技判定結果のバリテーション設定
	# 空は禁止
	with_options presence: true do
		validates :deadlift_first_attempt_result
		validates :deadlift_second_attempt_result
		validates :deadlift_third_attempt_result
	end
	# 重量の入力があったら成功か、失敗か選択させる
	validate :deadlift_first_attempt_is_not_be_not_attempted
	validate :deadlift_second_attempt_is_not_be_not_attempted
	validate :deadlift_third_attempt_is_not_be_not_attempted

	private

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
