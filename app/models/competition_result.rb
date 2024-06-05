class CompetitionResult < ApplicationRecord
  belongs_to :competition_record

  validates :competition_record_id, uniqueness: tru
  # 各計算値のバリデーション定義
  with_options numericality: true, allow_nil: true do
    validates :best_squat_weight
    validates :best_benchpress_weight
    validates :best_deadlift_weight
    validates :total_lifted_weight
    validates :ipf_points
  end
end
