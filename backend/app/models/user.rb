# frozen_string_literal: true


class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :recipes
  has_many :favorites, dependent: :destroy
 
 
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
 
 
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
 
 
  # active storageを用いたプロフィール画像を実装
  has_one_attached :avatar
  def avatar_url
    if avatar.attached?
      "#{ENV['CLOUDFRONT_URL']}/#{avatar.key}"
    else
      nil
    end
  end
 end
 