class User < ApplicationRecord
  
    belongs_to :section
    has_many :reports
    accepts_nested_attributes_for :reports
    has_secure_password

    def self.create_with_omniauth(auth)
        create! do |user|
          user.provider = auth["provider"]
          user.uid = auth["uid"]
          user.name = auth["info"]["name"]
        end
      end
    
end
