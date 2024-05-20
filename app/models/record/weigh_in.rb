class Record::WeighIn
  include ActiveModel::Model
  attr_accessor :weight
  validates :weight, presence: true, numericality: true
end
