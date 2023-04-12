class PrimaryUser < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :email,
            uniqueness: true,
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
            }
  validates :access_code, uniqueness: true
  validates :unique_url_hash, uniqueness: true

  before_create :generate_unique_link_and_access_code

  private

  def generate_unique_link_and_access_code
    self.access_code = SecureRandom.hex(10)
    self.unique_url_hash = SecureRandom.uuid
  end
end
