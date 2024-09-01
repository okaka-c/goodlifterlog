module Record
  class Squat
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :squat_first_attempt,
                  :squat_second_attempt,
                  :squat_third_attempt,
                  :squat_first_attempt_result,
                  :squat_second_attempt_result,
                  :squat_third_attempt_result

    # 初期化メソッド
    def initialize(attributes = {})
      super
      @squat_first_attempt ||= nil
      @squat_second_attempt ||= nil
      @squat_third_attempt ||= nil
      @squat_first_attempt_result ||= 'not_attempted'
      @squat_second_attempt_result ||= 'not_attempted'
      @squat_third_attempt_result ||= 'not_attempted'
    end

    # スクワット各試技のバリテーション設定
    validates :squat_first_attempt, numericality: { allow_nil: true },
                                    if: :should_validate_squat_first_attempt_numericality?
    validates :squat_second_attempt, numericality: { allow_nil: true },
                                     if: :should_validate_squat_second_attempt_numericality?
    validates :squat_third_attempt, numericality: { allow_nil: true },
                                    if: :should_validate_squat_third_attempt_numericality?

    # スクワット試技判定結果のバリテーション設定
    # 空は禁止
    with_options presence: true do
      validates :squat_first_attempt_result
      validates :squat_second_attempt_result
      validates :squat_third_attempt_result
    end

    # 重量の入力があったら成功か、失敗か選択させる
    validate :squat_first_attempt_is_not_be_not_attempted, unless: :should_validate_squat_first_attempt_numericality?
    validate :squat_second_attempt_is_not_be_not_attempted, unless: :should_validate_squat_second_attempt_numericality?
    validate :squat_third_attempt_is_not_be_not_attempted, unless: :should_validate_squat_third_attempt_numericality?
    # 成功か失敗選択時に重量が入力されていない
    # スクワット
    validate :squat_first_attempt_is_not_be_blank
    validate :squat_second_attempt_is_not_be_blank
    validate :squat_third_attempt_is_not_be_blank

    private

    # 重量の入力フォームに文字列が入力されていないか？
    # 第一試技
    def should_validate_squat_first_attempt_numericality?
      squat_first_attempt.present? && Float(squat_first_attempt, exception: false).nil?
    end

    # 第二試技
    def should_validate_squat_second_attempt_numericality?
      squat_second_attempt.present? && Float(squat_second_attempt, exception: false).nil?
    end

    # 第三試技
    def should_validate_squat_third_attempt_numericality?
      squat_third_attempt.present? && Float(squat_third_attempt, exception: false).nil?
    end

    # カスタムバリデータ　スクワット判定結果
    # 第一試技
    def squat_first_attempt_is_not_be_not_attempted
      if squat_first_attempt.present? && Float(squat_first_attempt,
                                               exception: false) >= 0 && squat_first_attempt_result == 'not_attempted'
        errors.add(:squat_first_attempt_result, 'は成功か失敗かを選んでください')
      end
    end

    # 第一試技
    def squat_second_attempt_is_not_be_not_attempted
      if squat_second_attempt.present? && Float(squat_second_attempt,
                                                exception: false) >= 0 && squat_second_attempt_result == 'not_attempted'
        errors.add(:squat_second_attempt_result, 'は成功か失敗かを選んでください')
      end
    end

    # 第二試技
    def squat_third_attempt_is_not_be_not_attempted
      if squat_third_attempt.present? && Float(squat_third_attempt,
                                               exception: false) >= 0 && squat_third_attempt_result == 'not_attempted'
        errors.add(:squat_third_attempt_result, 'は成功か失敗かを選んでください')
      end
    end

    # カスタムバリデータ 成功か失敗選択時に重量が入力されていない
    # 第一試技
    def squat_first_attempt_is_not_be_blank
      if (squat_first_attempt_result == 'success' ||
          squat_first_attempt_result == 'failure') &&
         squat_first_attempt.blank?
        errors.add(:squat_first_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
      end
    end

    # 第二試技
    def squat_second_attempt_is_not_be_blank
      if (squat_second_attempt_result == 'success' ||
          squat_second_attempt_result == 'failure') &&
         squat_second_attempt.blank?
        errors.add(:squat_second_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
      end
    end

    # 第三試技
    def squat_third_attempt_is_not_be_blank
      if (squat_third_attempt_result == 'success' ||
          squat_third_attempt_result == 'failure') &&
         squat_third_attempt.blank?
        errors.add(:squat_third_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
      end
    end
  end
end
