# rubocop:disable Metrics/ClassLength
class CompetitionRecord < ApplicationRecord
  belongs_to :competition
  has_one :competition_result, dependent: :destroy

  # スクワット 判定結果定義
  enum :squat_first_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :squat_first
  enum :squat_second_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :squat_second
  enum :squat_third_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :squat_third
  # ベンチプレス 判定結果定義
  enum :benchpress_first_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :benchpress_first
  enum :benchpress_second_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :benchpress_second
  enum :benchpress_third_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :benchpress_third
  # デッドリフト　判定結果定義
  enum :deadlift_first_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :deadlift_first
  enum :deadlift_second_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :deadlift_second
  enum :deadlift_third_attempt_result, { not_attempted: 0, success: 1, failure: 2 }, prefix: :deadlift_third

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
  # 成功か失敗選択時に重量が入力されていない
  # スクワット
  validate :squat_first_attempt_is_not_be_blank
  validate :squat_second_attempt_is_not_be_blank
  validate :squat_third_attempt_is_not_be_blank
  # ベンチプレス
  validate :benchpress_first_attempt_is_not_be_blank
  validate :benchpress_second_attempt_is_not_be_blank
  validate :benchpress_third_attempt_is_not_be_blank
  # デッドリフト
  validate :deadlift_first_attempt_is_not_be_blank
  validate :deadlift_second_attempt_is_not_be_blank
  validate :deadlift_third_attempt_is_not_be_blank

  # カスタムバリデータ　スクワット判定結果
  def squat_first_attempt_is_not_be_not_attempted
    if squat_first_attempt.present? &&
       squat_first_attempt >= 0 &&
       squat_first_attempt_result == 'not_attempted'
      errors.add(:squat_first_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  def squat_second_attempt_is_not_be_not_attempted
    if squat_second_attempt.present? &&
       squat_second_attempt >= 0 &&
       squat_second_attempt_result == 'not_attempted'
      errors.add(:squat_second_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  def squat_third_attempt_is_not_be_not_attempted
    if squat_third_attempt.present? &&
       squat_third_attempt >= 0 &&
       squat_third_attempt_result == 'not_attempted'
      errors.add(:squat_third_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  # カスタムバリデータ　ベンチプレス判定結果
  def benchpress_first_attempt_is_not_be_not_attempted
    if benchpress_first_attempt.present? &&
       benchpress_first_attempt >= 0 &&
       benchpress_first_attempt_result == 'not_attempted'
      errors.add(:benchpress_first_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  def benchpress_second_attempt_is_not_be_not_attempted
    if benchpress_second_attempt.present? &&
       benchpress_second_attempt >= 0 &&
       benchpress_second_attempt_result == 'not_attempted'
      errors.add(:benchpress_second_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  def benchpress_third_attempt_is_not_be_not_attempted
    if benchpress_third_attempt.present? &&
       benchpress_third_attempt >= 0 &&
       benchpress_third_attempt_result == 'not_attempted'
      errors.add(:benchpress_third_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  # カスタムバリデータ　デッドリフト判定結果
  def deadlift_first_attempt_is_not_be_not_attempted
    if deadlift_first_attempt.present? &&
       deadlift_first_attempt >= 0 &&
       deadlift_first_attempt_result == 'not_attempted'
      errors.add(:deadlift_first_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  def deadlift_second_attempt_is_not_be_not_attempted
    if deadlift_second_attempt.present? &&
       deadlift_second_attempt >= 0 &&
       deadlift_second_attempt_result == 'not_attempted'
      errors.add(:deadlift_second_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  def deadlift_third_attempt_is_not_be_not_attempted
    if deadlift_third_attempt.present? &&
       deadlift_third_attempt >= 0 &&
       deadlift_third_attempt_result == 'not_attempted'
      errors.add(:deadlift_third_attempt_result, 'は成功か失敗かを選んでください')
    end
  end

  # 成功か失敗選択時に重量が入力されていない
  # スクワット
  def squat_first_attempt_is_not_be_blank
    if (squat_first_attempt_result == 'success' || squat_first_attempt_result == 'failure') &&
       squat_first_attempt.blank?
      errors.add(:squat_first_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  def squat_second_attempt_is_not_be_blank
    if (squat_second_attempt_result == 'success' || squat_second_attempt_result == 'failure') &&
       squat_second_attempt.blank?
      errors.add(:squat_second_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  def squat_third_attempt_is_not_be_blank
    if (squat_third_attempt_result == 'success' || squat_third_attempt_result == 'failure') &&
       squat_third_attempt.blank?
      errors.add(:squat_third_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  # 成功か失敗選択時に重量が入力されていない
  # ベンチプレス
  def benchpress_first_attempt_is_not_be_blank
    if (benchpress_first_attempt_result == 'success' || benchpress_first_attempt_result == 'failure') &&
       benchpress_first_attempt.blank?
      errors.add(:benchpress_first_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  def benchpress_second_attempt_is_not_be_blank
    if (benchpress_second_attempt_result == 'success' || benchpress_second_attempt_result == 'failure') &&
       benchpress_second_attempt.blank?
      errors.add(:benchpress_second_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  def benchpress_third_attempt_is_not_be_blank
    if (benchpress_third_attempt_result == 'success' || benchpress_third_attempt_result == 'failure') &&
       benchpress_third_attempt.blank?
      errors.add(:benchpress_third_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  # 成功か失敗選択時に重量が入力されていない
  # デッドリフト
  def deadlift_first_attempt_is_not_be_blank
    if (deadlift_first_attempt_result == 'success' || deadlift_first_attempt_result == 'failure') &&
       deadlift_first_attempt.blank?
      errors.add(:deadlift_first_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  def deadlift_second_attempt_is_not_be_blank
    if (deadlift_second_attempt_result == 'success' || deadlift_second_attempt_result == 'failure') &&
       deadlift_second_attempt.blank?
      errors.add(:deadlift_second_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  def deadlift_third_attempt_is_not_be_blank
    if (deadlift_third_attempt_result == 'success' || deadlift_third_attempt_result == 'failure') &&
       deadlift_third_attempt.blank?
      errors.add(:deadlift_third_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
    end
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/BlockLength
  def result_save(competition_record, competition, gender)
    ActiveRecord::Base.transaction do
      # ステップ1 @competition_recordの内容をテーブルに保存/更新
      competition_record.save!

      # ステップ2 ここからCompetitionResultテーブルのレコード保存/更新のため計算開始
      # スクワットの最高重量を算出
      # 試技結果の重量を保存に成功したインスタンスから抽出
      squat_attempt = {
        squat_first_attempt: competition_record.squat_first_attempt,
        squat_second_attempt: competition_record.squat_second_attempt,
        squat_third_attempt: competition_record.squat_third_attempt
      }
      squat_attempts = []
      # 成功試技のみ、配列に格納していく
      squat_attempt.each do |key, value|
        result_key = :"#{key}_result"
        squat_attempts << value if competition_record[result_key] == 'success'
      end
      # 成功試技の中で、最高重量を変数に代入
      best_squat_weight = squat_attempts.empty? ? 0 : squat_attempts.max

      # ベンチプレスの最高重量を算出
      benchpress_attempt = {
        benchpress_first_attempt: competition_record.benchpress_first_attempt,
        benchpress_second_attempt: competition_record.benchpress_second_attempt,
        benchpress_third_attempt: competition_record.benchpress_third_attempt
      }
      benchpress_attempts = []
      # 成功試技のみ、配列に格納していく
      benchpress_attempt.each do |key, value|
        result_key = :"#{key}_result"
        benchpress_attempts << value if competition_record[result_key] == 'success'
      end
      # 成功試技の中で、最高重量を変数に代入
      best_benchpress_weight = benchpress_attempts.empty? ? 0 : benchpress_attempts.max

      # デッドリフトの最高重量を算出
      deadlift_attempt = {
        deadlift_first_attempt: competition_record.deadlift_first_attempt,
        deadlift_second_attempt: competition_record.deadlift_second_attempt,
        deadlift_third_attempt: competition_record.deadlift_third_attempt
      }
      deadlift_attempts = []
      # 成功試技のみ、配列に格納していく
      deadlift_attempt.each do |key, value|
        result_key = :"#{key}_result"
        deadlift_attempts << value if competition_record[result_key] == 'success'
      end
      # 成功試技の中で、最高重量を変数に代入
      best_deadlift_weight = deadlift_attempts.empty? ? 0 : deadlift_attempts.max

      # トータル重量を出す
      total_lifted_weight =
        case competition.category
        when 'パワーリフティング'
          best_squat_weight + best_benchpress_weight + best_deadlift_weight
        when 'シングルベンチプレス'
          best_benchpress_weight
        end

      # IPFポイントの計算をする
      # 係数a,b,cの決定
      coefficients = CompetitionResult::COEFFICIENTS[gender][competition.gearcategory_type][competition.category]
      a = coefficients[:a]
      b = coefficients[:b]
      c = coefficients[:c]
      # 検量体重
      body_weight = competition_record.weight
      # IPFポイント計算式
      # rubocop:disable Lint/AmbiguousOperatorPrecedence
      ipf_gl_points = total_lifted_weight * 100 / (a - b * Math.exp(-c * body_weight))
      # rubocop:enable Lint/AmbiguousOperatorPrecedence
      # CompetitionResultのインスタンス生成し、いままでの計算結果を代入する
      results_params = {
        competition_record_id: competition_record.id,
        best_squat_weight:,
        best_benchpress_weight:,
        best_deadlift_weight:,
        total_lifted_weight:,
        ipf_points: ipf_gl_points
      }
      if competition_record.competition_result.nil?
        # 結果がなければ、新しいCompetitionResultインスタンスを作成
        @competition_result = CompetitionResult.new(results_params)
      else
        # 結果登録済ならば、新しいCompetitionResultインスタンスを作成
        @competition_result = competition_record.competition_result
        @competition_result.assign_attributes(results_params)
      end
      # 保存
      @competition_result.save!
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/BlockLength

  # rubocop:disable Metrics/AbcSize
  def ipf_points_update(competition_record, competition, gender)
    # IPFポイントの計算をする
    # 係数a,b,cの決定
    coefficients = CompetitionResult::COEFFICIENTS[gender][competition.gearcategory_type][competition.category]
    a = coefficients[:a]
    b = coefficients[:b]
    c = coefficients[:c]
    # 検量体重
    body_weight = competition_record.weight
    total_lifted_weight = competition_record.competition_result.total_lifted_weight
    # IPFポイント計算式
    # rubocop:disable Lint/AmbiguousOperatorPrecedence
    total_lifted_weight * 100 / (a - b * Math.exp(-c * body_weight))
    # rubocop:enable Lint/AmbiguousOperatorPrecedence
  end
  # rubocop:enable Metrics/AbcSize
end
# rubocop:enable Metrics/ClassLength
