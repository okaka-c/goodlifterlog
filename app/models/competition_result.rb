class CompetitionResult < ApplicationRecord
  belongs_to :competition_record

  validates :competition_record_id, uniqueness: true
end
