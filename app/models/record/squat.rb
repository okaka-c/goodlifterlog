class Record::Squat
	include ActiveModel::Model
	attr_accessor :squat_first_attempt,
								:squat_second_attempt,
								:squat_third_attempt,
								:squat_first_attempt_result,
								:squat_second_attempt_result,
								:squat_third_attempt_result
	# スクワット各試技のバリテーション設定
	with_options numericality: true, allow_nil: true do
		validates :squat_first_attempt
		validates :squat_second_attempt
		validates :squat_third_attempt
	end
	# スクワット試技判定結果のバリテーション設定
		# 空は禁止
	with_options presence: true do
		validates :squat_first_attempt_result
		validates :squat_second_attempt_result
		validates :squat_third_attempt_result
	end
	# 重量の入力があったら成功か、失敗か選択させる
	validate :squat_first_attempt_is_not_be_not_attempted
	validate :squat_second_attempt_is_not_be_not_attempted
	validate :squat_third_attempt_is_not_be_not_attempted

	private
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
end
