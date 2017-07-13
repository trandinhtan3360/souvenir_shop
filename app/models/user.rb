class User < ApplicationRecord
  has_many :comments
  has_many :orders 
  attr_accessor :remember, :passwords
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest, :activation_token
  attr_accessor :remember_digest
  attr_accessor :current_user
  
  before_save{ email.downcase! }
  validates :username,  presence: true, length:{ maximum: Settings.maximum }
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
      remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end
  end
    
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
end
