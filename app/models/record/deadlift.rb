module Record
  class Deadlift
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :deadlift_first_attempt,
                  :deadlift_second_attempt,
                  :deadlift_third_attempt,
                  :deadlift_first_attempt_result,
                  :deadlift_second_attempt_result,
                  :deadlift_third_attempt_result

    # 初期化メソッド
    def initialize(attributes = {})
      super
      @deadlift_first_attempt ||= nil
      @deadlift_second_attempt ||= nil
      @deadlift_third_attempt ||= nil
      @deadlift_first_attempt_result ||= 'not_attempted'
      @deadlift_second_attempt_result ||= 'not_attempted'
      @deadlift_third_attempt_result ||= 'not_attempted'
    end

    # スクワット各試技のバリテーション設定
    validates :deadlift_first_attempt, numericality: { allow_nil: true },
                                       if: :should_validate_deadlift_first_attempt_numericality?
    validates :deadlift_second_attempt, numericality: { allow_nil: true },
                                        if: :should_validate_deadlift_second_attempt_numericality?
    validates :deadlift_third_attempt, numericality: { allow_nil: true },
                                       if: :should_validate_deadlift_third_attempt_numericality?

    # スクワット試技判定結果のバリテーション設定
    # 空は禁止
    with_options presence: true do
      validates :deadlift_first_attempt_result
      validates :deadlift_second_attempt_result
      validates :deadlift_third_attempt_result
    end

    # 重量の入力があったら成功か、失敗か選択させる
    validate :deadlift_first_attempt_is_not_be_not_attempted,
             unless: :should_validate_deadlift_first_attempt_numericality?
    validate :deadlift_second_attempt_is_not_be_not_attempted,
             unless: :should_validate_deadlift_second_attempt_numericality?
    validate :deadlift_third_attempt_is_not_be_not_attempted,
             unless: :should_validate_deadlift_third_attempt_numericality?

    # 成功か失敗選択時に重量が入力されていない
    validate :deadlift_first_attempt_is_not_be_blank
    validate :deadlift_second_attempt_is_not_be_blank
    validate :deadlift_third_attempt_is_not_be_blank

    private

    # 重量の入力フォームに文字列が入力されていないか？
    # 第一試技
    def should_validate_deadlift_first_attempt_numericality?
      deadlift_first_attempt.present? && Float(deadlift_first_attempt, exception: false).nil?
    end

    # 第二試技
    def should_validate_deadlift_second_attempt_numericality?
      deadlift_second_attempt.present? && Float(deadlift_second_attempt, exception: false).nil?
    end

    # 第三試技
    def should_validate_deadlift_third_attempt_numericality?
      deadlift_third_attempt.present? && Float(deadlift_third_attempt, exception: false).nil?
    end

    # カスタムバリデータ　スクワット判定結果
    # 第一試技
    def deadlift_first_attempt_is_not_be_not_attempted
      if deadlift_first_attempt.present? &&
         Float(deadlift_first_attempt, exception: false) >= 0 &&
         deadlift_first_attempt_result == 'not_attempted'
        errors.add(:deadlift_first_attempt_result, 'は成功か失敗かを選んでください')
      end
    end

    # 第一試技
    def deadlift_second_attempt_is_not_be_not_attempted
      if deadlift_second_attempt.present? &&
         Float(deadlift_second_attempt, exception: false) >= 0 &&
         deadlift_second_attempt_result == 'not_attempted'
        errors.add(:deadlift_second_attempt_result, 'は成功か失敗かを選んでください')
      end
    end

    # 第二試技
    def deadlift_third_attempt_is_not_be_not_attempted
      if deadlift_third_attempt.present? &&
         Float(deadlift_third_attempt, exception: false) >= 0 &&
         deadlift_third_attempt_result == 'not_attempted'
        errors.add(:deadlift_third_attempt_result, 'は成功か失敗かを選んでください')
      end
    end

    # 成功か失敗選択時に重量が入力されていない
    # デッドリフト
    def deadlift_first_attempt_is_not_be_blank
      if (deadlift_first_attempt_result == 'success' ||
          deadlift_first_attempt_result == 'failure') &&
         deadlift_first_attempt.blank?
        errors.add(:deadlift_first_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
      end
    end

    def deadlift_second_attempt_is_not_be_blank
      if (deadlift_second_attempt_result == 'success' ||
          deadlift_second_attempt_result == 'failure') &&
         deadlift_second_attempt.blank?
        errors.add(:deadlift_second_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
      end
    end

    def deadlift_third_attempt_is_not_be_blank
      if (deadlift_third_attempt_result == 'success' ||
          deadlift_third_attempt_result == 'failure') &&
         deadlift_third_attempt.blank?
        errors.add(:deadlift_third_attempt, 'は成功か失敗を選択したときは重量を入力して下さい。')
      end
    end
  end
end
