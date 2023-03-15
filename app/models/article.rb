class Article < ApplicationRecord
    validates :title, presence: true 
    validates :body, presence:true, length: {minimum: 70}

    # validate : indicates this is a custom validation 
    validate :title_shouldbeunique
    validate :body_shouldnothavecursewords 

    private 
    def title_shouldbeunique
      if Article.where("title = ? AND created_at >= ?", self.title, Time.zone.now.beginning_of_month).any?
        errors.add(:title, "has already been taken this month.")
    end 

    private
        def 
              if self.body && self.body.match(/|damn|/i)
                errors.add(:body, "this word is not permitted.")
              end
        end
end
