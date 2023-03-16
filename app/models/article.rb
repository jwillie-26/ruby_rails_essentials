class Article < ApplicationRecord
  validates :title, presence: true 
  validates :body, presence:true, length: {minimum: 7}

  validate :title_should_be_unique
  validate :body_should_not_have_curse_words 

  validate :title_should_not_contain_special_characters
  validate :body_should_not_contain_links
  validate :author_should_not_be_blacklisted

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

  private
  def title_should_not_contain_special_characters
    if title.present? && title.match(/[^[:alnum:]\s]/)
      errors.add(:title, "should not contain special characters")
    end
  end

  private
  def body_should_not_contain_links
    if body.include?("http://") || body.include?("https://")
      errors.add(:body, "should not contain links")
    end
  end

  private
  # I am assuming that we have a Blacklist model with a name column that contains the names of blacklisted authors.
  def author_should_not_be_blacklisted
    if Blacklist.exists?(name: author_name)
      errors.add(:author_name, "is blacklisted")
    end
  end


end