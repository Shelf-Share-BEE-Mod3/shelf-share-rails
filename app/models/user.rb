class User < ApplicationRecord

  def self.update_or_create(auth)
    User.find_by(uid: auth[:uid]) || new_user(auth)
  end

  def self.new_user(auth)
    user = User.new(new_user_attributes(auth))
    user if user.save!
  end

  def self.new_user_attributes(auth)
    {
      provider: auth[:provider],
      uid: auth[:uid],
      email: auth[:info][:email],
      first_name: auth[:info][:first_name],
      last_name: auth[:info][:last_name],
      token: auth[:credentials][:token],
      refresh_token: auth[:credentials][:refresh_token],
      oauth_expires_at: auth[:credentials][:expires_at]
    }
  end
end
