class User < ActiveRecord::Base
    validates :email,
        presence: true,
        format: {with: /@/, allow_blank: true},
        uniqueness: {case_sensitive: false, allow_blank: true}

    has_secure_password
end