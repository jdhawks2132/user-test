class DelegateUser < ApplicationRecord
  belongs_to :primary_user

  validates :first_name, :last_name, :email, presence: true
  validates :email,
            uniqueness: true,
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
            }
  validates :access_code, uniqueness: true

  before_create :generate_unique_access_code

  private

  def generate_unique_access_code
    self.access_code = SecureRandom.hex(10)
  end
end
