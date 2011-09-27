class Artist < ActiveRecord::Base
  has_many :albums
  has_many :songs, :through => :albums

  before_create { generate_token(:public_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Artist.exists?(column => self[column])
  end
end
