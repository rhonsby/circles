class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_nil: true

  before_validation :ensure_session_token

  has_many :friend_circles, foreign_key: :owner_id

  has_many :circle_memberships
  has_many :friends, through: :circle_memberships, source: :friend

  has_many :posts, foreign_key: :author_id

  attr_reader :password

  def self.find_by_credentials(creds = {})
    user = User.find_by(email: creds[:email])
    user.try(:is_password?, creds[:password]) ? user : nil
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.empty?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(password_digest).is_password?(unencrypted_password)
  end

  def ensure_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
    session_token
  end
end
