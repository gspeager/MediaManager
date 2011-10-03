class User < ActiveRecord::Base
  attr_protected :auth_token, :public_token

  has_secure_password

  has_many :songs
  has_many :notices  

  validates_confirmation_of :password, :class => "error"
  validates_presence_of :password, :on => :create, :class => "error"
  validates_presence_of :email, :class => "error"
  validates_uniqueness_of :email, :class => "error"

  before_create { generate_token(:auth_token) }
  before_create { generate_token(:public_token) }

  def display_name
    if self.firstname
      return self.firstname + " " + self.lastname
    else
      return self.email
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.hex(20)
    end while User.exists?(column => self[column])
  end

end
