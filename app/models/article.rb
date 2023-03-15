class Article < ApplicationRecord
  validates :title, presence: true 
  validates :body, presence:true, length: {minimum: 7}

  validate :title_should_be_unique
  validate :body_should_not_have_curse_words 

  private 
  def title_should_be_unique
    if Article.where("title = ? AND created_at >= ?", self.title, Time.zone.now.beginning_of_month).any?
      errors.add(:title, "has already been taken this month.")
    end
  end 

  private
  def body_should_not_have_curse_words 
    if self.body && self.body.match(/(damn|curseword)/i)
      errors.add(:body, "contains a curse word.")
    end    
  end
end
