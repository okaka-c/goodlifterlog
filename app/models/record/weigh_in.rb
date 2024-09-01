module Record
  class WeighIn
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :weight, :competition_id

    validates :weight, presence: true, numericality: true
    validate :unique_competition_id

    private

    def unique_competition_id
      return unless CompetitionRecord.exists?(competition_id:)

      errors.add(:competition_id, 'の試技結果はすでに存在しています')
    end
  end
end
