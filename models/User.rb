class User < ActiveRecord::Base
    validates :email,
        presence: true,
        format: {with: /@/, allow_blank: true},
        uniqueness: {case_sensitive: false, allow_blank: true}

    has_secure_password

    def password_reset 
        update(password_reset_token: SecureRandom.hex)
    end
end