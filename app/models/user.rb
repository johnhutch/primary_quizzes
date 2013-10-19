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
end