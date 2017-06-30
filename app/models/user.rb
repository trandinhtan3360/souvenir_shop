class User < ApplicationRecord
  has_many :comment
  has_many :orders 
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :passwords
  before_save :downcase_email
  attr_accessor :remember_digest
  attr_accessor :current_user
  
  before_save{ email.downcase! }
  validates :name,  presence: true, length:{ maximum: Settings.maximum }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:{ maximum: Settings.maximum },
   format:{ with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive: false }
  
  has_secure_password
  validates :password, presence: true, length:{ minimum: Settings.minimum }, allow_nil: true

  scope :newest, ->{order created_at: :desc}
  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end
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
