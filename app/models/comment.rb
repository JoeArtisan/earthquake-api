class Comment < ApplicationRecord
    validates :body, presence: true
    belongs_to :feature

    def formatted_created_at
        created_at.strftime("%d/%m/%Y %H:%M")
    end
end