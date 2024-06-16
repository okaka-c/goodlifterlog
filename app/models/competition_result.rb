class CompetitionResult < ApplicationRecord
  belongs_to :competition_record

  validates :competition_record_id, uniqueness: true
  # 各計算値のバリデーション定義
  with_options numericality: true, allow_nil: true do
    validates :best_squat_weight
    validates :best_benchpress_weight
    validates :best_deadlift_weight
    validates :total_lifted_weight
    validates :ipf_points
  end

  # IPFポイントの係数を定義
  COEFFICIENTS = {
    "man" => {
      "equipped" => {
        "パワーリフティング" => { a: 1236.25115, b: 1449.21864, c: 0.01644 },
        "シングルベンチプレス" => { a: 381.22073, b: 733.79378, c: 0.02398 }
      },
      "raw" => {
        "パワーリフティング" => { a: 1199.72839, b: 1025.18162, c: 0.00921 },
        "シングルベンチプレス" => { a: 320.98041, b: 281.40258, c: 0.01008 }
      }
    },
    "women" => {
      "equipped" => {
        "パワーリフティング" => { a: 758.63878, b: 949.31382, c: 0.02435 },
        "シングルベンチプレス" => { a: 221.82209, b: 357.00377, c: 0.02937 }
      },
      "raw" => {
        "パワーリフティング" => { a: 610.32796, b: 1045.59282, c: 0.03048 },
        "シングルベンチプレス" => { a: 142.40398, b: 442.52671, c: 0.04724 }
      }
    }
  }.freeze

  def total_subtraction(result, past_result)
    result.total_lifted_weight - past_result.total_lifted_weight
  end

  def squat_subtraction(result, past_result)
    result.best_squat_weight - past_result.best_squat_weight
  end

  def benchpress_subtraction(result, past_result)
    result.best_benchpress_weight - past_result.best_benchpress_weight
  end

  def deadlift_subtraction(result, past_result)
    result.best_deadlift_weight - past_result.best_deadlift_weight
  end

  def ipf_points_subtraction(result, past_result)
    (result.ipf_points - past_result.ipf_points).round(2)
  end
end
