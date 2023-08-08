# frozen_string_literal: true

class User < ApplicationRecord
  before_save :set_token
  VER = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i

  has_one :outlet
  has_many :orders

  before_validation :normalize_email

  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false },
                    format: { with: VER }
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
  validates :role, presence: true

  def normalize_email
    self.email = email.to_s.strip.downcase
  end

  def set_token
    self.auth_token = "Auth#{rand(1..5000)}"
  end
end
