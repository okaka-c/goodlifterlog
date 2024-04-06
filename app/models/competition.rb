class Competition < ApplicationRecord
  belongs_to :user

  validates: name, presence: true, length: { maximum: 255 }
  validates: venue, length: { maximum: 255 }
  validates: date, presence: true
  validates: type, presence: true
  validates: gearcategory_type, presence: true
  validates: category, presence: true
  validates: age_group, presence: true
  validates: weight_class, presence: true
  validates: participation_status, presence: true
end
