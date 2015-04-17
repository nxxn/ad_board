class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :street, :post_index, :town, :country, :phone, :login, :current_email, :new_email, :current_password, :avatar, :is_admin, :approved, :balance, :rating

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login, :current_email, :new_email, :current_password

  has_many :tasks, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_attached_file :avatar,
                    :storage => :s3,
                    :styles => { :thumb => "69x69#"},
                    :convert_options => {:thumb => '-strip -interlace plane -quality 90'},
                    :path => "user_avatars/:id.:style.:extension"

  validates :username,
            :presence => true,
            :uniqueness => {
              :case_sensitive => false
            }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  acts_as_messageable

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

  def update_rating
    positive_reviews_count = Review.where(user_id: id, positive: true).count
    negative_reviews_count = Review.where(user_id: id, positive: false).count
    user_total_revews_count = positive_reviews_count + negative_reviews_count * 2
    self.update_attribute(:rating, positive_reviews_count * 100 / user_total_revews_count)
  end

  def paypal_url(return_path)
    values = {
      business: "n.gnotov-facilitator@gmail.com",
      cmd: "_xclick",
      upload: 1,
      return: return_path,
      invoice: SecureRandom.uuid,
      amount: 10,
      item_name: "EG credits",
      quantity: '1',
      notify_url: "http://ad_board.ngrok.com/hook"
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
