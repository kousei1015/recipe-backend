class Instruction < ApplicationRecord
  belongs_to :recipe
  # バリデーションを追加
  validates :description, presence: true, length: { maximum: 200 }
end
