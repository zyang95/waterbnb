class User < ApplicationRecord
  enum role: [ :customer, :moderator, :superadmin]
  mount_uploader :profile, ProfileUploader
  include Clearance::User
   has_many :authentications, dependent: :destroy
   has_many :listings, dependent: :destroy
   has_many :reservations, dependent: :destroy
    def self.create_with_auth_and_hash(authentication, auth_hash)
      user = self.create!(
        first_name: auth_hash["info"]["first_name"],
        last_name: auth_hash["info"]["last_name"], 
        email: auth_hash["extra"]["raw_info"]["email"],
        password: SecureRandom.hex(10)
      )
      user.authentications << authentication
      return user
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end
end
