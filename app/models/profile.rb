class Profile < ApplicationRecord
  belongs_to :user

  validates :gender, presence: true
  validates :birthday, presence: true

  # enum定義
  enum gender: { man: 0, women: 1 } 

end
