class User < ActiveRecord::Base
  has_many :questions

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to the real persisted field like 'username'
  attr_accessor :login

  # Overriding to customize finder methods for authentication with email or username
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def update_elo(other_elo, success)

    # Set to 1 if success is true, 0 if success is false
    actual_score = success ? 1 : 0

    # Default seems to be 400 everywhere in the ELO world, also known as F Factor
    rating_disparity = 400

    # Also known as K Factor, and is based on the ELOs of the parties involved
    match_importance = 16
    if(self.elo < 2400 || other_elo < 2400)
      match_importance = 24
    end
    if(self.elo < 2100 || other_elo < 2100)
      match_importance = 32
    end

    expected_score = 1 / (1 + 10**((other_elo - self.elo).to_f / rating_disparity))

    self.elo = (self.elo + match_importance * (actual_score - expected_score)).round(0)

    if self.elo < 100
      self.elo = 100
    end

    self.save

  end

end