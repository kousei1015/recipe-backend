class Recipe < ApplicationRecord
  include Rails.application.routes.url_helpers
 
 
  belongs_to :user
  has_one_attached :image
 
 
  def image_url
    if image.attached?
      "#{ENV['CLOUDFRONT_URL']}/#{image.key}"
    else
      nil
    end
  end

  has_many :recipe_ingredients, dependent: :destroy
  
  has_many :ingredients, through: :recipe_ingredients
 
  has_many :favorites, dependent: :destroy
 
  has_many :instructions, dependent: :destroy
 
  validates :name, presence: true
  validates :user, presence: true
 
end 