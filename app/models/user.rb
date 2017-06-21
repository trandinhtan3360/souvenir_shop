class User < ApplicationRecord
  has_many :microposts
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  
  before_save{ email.downcase! }
  validates :name,  presence: true, length:{ maximum: Settings.minimum }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:{ maximum: Settings.maximum },
   format:{ with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive: false }
  validates :email, presence: true, length:{ maximum: Settings.maximum }
  has_secure_password
  validates :password, presence: true, length:{ minimum: Settings.minimum }, allow_nil: true

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    remember_token = new_token
    update_attribute(:remember_digest, digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def downcase_email
    self.email = email.downcase
  end
end
