class User < ActiveRecord::Base
  attr_protected :auth_token, :public_token

  has_secure_password

  has_many :songs  

  validates_confirmation_of :password, :class => "error"
  validates_presence_of :password, :on => :create, :class => "error"
  validates_presence_of :email, :class => "error"
  validates_uniqueness_of :email, :class => "error"

  before_create { generate_token(:auth_token) }
  before_create { generate_token(:public_token) }

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
