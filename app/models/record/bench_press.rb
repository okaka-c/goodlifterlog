class Record::BenchPress
	include ActiveModel::Model
	include ActiveModel::Validations

	attr_accessor :benchpress_first_attempt,
								:benchpress_second_attempt,
								:benchpress_third_attempt,
								:benchpress_first_attempt_result,
								:benchpress_second_attempt_result,
								:benchpress_third_attempt_result

	# 初期化メソッド
	def initialize(attributes = {})
    super
		@benchpress_first_attempt ||= nil
    @benchpress_second_attempt ||= nil
    @benchpress_third_attempt ||= nil
    @benchpress_first_attempt_result ||= "not_attempted"
    @benchpress_second_attempt_result ||= "not_attempted"
    @benchpress_third_attempt_result ||= "not_attempted"
  end

	# スクワット各試技のバリテーション設定
	validates :benchpress_first_attempt, numericality: { allow_nil: true }, if: :should_validate_benchpress_first_attempt_numericality?
	validates :benchpress_second_attempt, numericality: { allow_nil: true }, if: :should_validate_benchpress_second_attempt_numericality?
	validates :benchpress_third_attempt, numericality: { allow_nil: true }, if: :should_validate_benchpress_third_attempt_numericality?


	# スクワット試技判定結果のバリテーション設定
		# 空は禁止
	with_options presence: true do
		validates :benchpress_first_attempt_result
		validates :benchpress_second_attempt_result
		validates :benchpress_third_attempt_result
	end

	# 重量の入力があったら成功か、失敗か選択させる
	validate :benchpress_first_attempt_is_not_be_not_attempted, unless: :should_validate_benchpress_first_attempt_numericality?
	validate :benchpress_second_attempt_is_not_be_not_attempted, unless: :should_validate_benchpress_second_attempt_numericality?
	validate :benchpress_third_attempt_is_not_be_not_attempted, unless: :should_validate_benchpress_third_attempt_numericality?

	private
	# 重量の入力フォームに文字列が入力されていないか？
	# 第一試技
	def should_validate_benchpress_first_attempt_numericality?
		benchpress_first_attempt.present? && Float(benchpress_first_attempt, exception: false).nil?
	end
	# 第二試技
	def should_validate_benchpress_second_attempt_numericality?
		benchpress_second_attempt.present? && Float(benchpress_second_attempt, exception: false).nil?
	end
	# 第三試技
	def should_validate_benchpress_third_attempt_numericality?
		benchpress_third_attempt.present? && Float(benchpress_third_attempt, exception: false).nil?
	end

	# カスタムバリデータ　スクワット判定結果
	# 第一試技
	def benchpress_first_attempt_is_not_be_not_attempted
		if benchpress_first_attempt.present? && Float(benchpress_first_attempt, exception: false) >= 0 && benchpress_first_attempt_result == "not_attempted"
			errors.add(:benchpress_first_attempt_result, "は成功か失敗かを選んでください")
		end
	end
	# 第一試技
	def benchpress_second_attempt_is_not_be_not_attempted
		if benchpress_second_attempt.present? && Float(benchpress_second_attempt, exception: false) >= 0 && benchpress_second_attempt_result == "not_attempted"
			errors.add(:benchpress_second_attempt_result, "は成功か失敗かを選んでください")
		end
	end
	# 第二試技
	def benchpress_third_attempt_is_not_be_not_attempted
		if benchpress_third_attempt.present? && Float(benchpress_third_attempt, exception: false) >= 0 && benchpress_third_attempt_result == "not_attempted"
			errors.add(:benchpress_third_attempt_result, "は成功か失敗かを選んでください")
		end
	end
end
