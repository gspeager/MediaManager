class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs

  before_create { generate_token(:public_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Album.exists?(column => self[column])
  end
end
