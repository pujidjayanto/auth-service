class User < ApplicationRecord
  has_secure_password

  validates :user_id,
            presence: true,
            uniqueness: true,
            length: { in: 6..20 },
            format: {
              with: /\A[a-zA-Z0-9]+\z/,
              message: "Incorrect character pattern"
            }

  validates :password,
            presence: true,
            length: { in: 8..20 },
            format: {
              with: /\A[!-~]+\z/,
              message: "Incorrect character pattern"
            }

  validate :user_id_cannot_start_with_test

  private def user_id_cannot_start_with_test
    if user_id.present? && user_id&.start_with?("Test")
      errors.add(:user_id, "cannot start with 'Test'")
    end
  end
end
