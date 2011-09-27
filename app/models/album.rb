class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs



  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Album.exists?(column => self[column])
  end
end
