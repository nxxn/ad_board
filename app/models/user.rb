class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :street, :post_index, :town, :country, :phone, :login, :current_email, :new_email, :current_password

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login, :current_email, :new_email, :current_password

  has_many :tasks, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates :username,
            :presence => true,
            :uniqueness => {
              :case_sensitive => false
            }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  def profile_progress
    profile = [first_name, last_name, street, post_index, town, country]
    progress = 0
    profile.each do |field|
      progress += 1 unless field.blank?
    end
    if progress < 6
      false
    elsif progress == 6
      true
    end
  end

  def no_first_name?
    first_name.blank?
  end

  def no_last_name?
    last_name.blank?
  end

  def no_street?
    street.blank?
  end

  def no_post_index?
    post_index.blank?
  end

  def no_town?
    town.blank?
  end

  def no_country?
    country.blank?
  end
end
