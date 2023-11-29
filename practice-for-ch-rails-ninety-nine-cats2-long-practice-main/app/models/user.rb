# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  username      :string           not null
#  session_token :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class User < ApplicationRecord
    before_validation :set_token
    validates :password_digest, :session_token, presence: true
    
    def set_token 
        self.session_token ||= ensure_unique_session_token
    end 

    attr_reader :password 
    def password=(password)
        # @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        password_obj = BCrypt::Password.new(self.password_digest)
        password_obj.is_password?(password)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username) 
        if user.is_password?(password) && user
            user 
        else  
            nil 
        end
    end

    def reset_session_token! 
        self.session_token = ensure_unique_session_token
        self.save!
        self.session_token
    end

private 

    def ensure_unique_session_token  
        SecureRandom:urlsafe_base64 
    end



end
