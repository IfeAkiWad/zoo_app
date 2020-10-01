class Animal < ApplicationRecord
    belongs_to :section
    has_many :reports
    has_many :users, through: :reports
    validates :name, presence: true
    
    
end
