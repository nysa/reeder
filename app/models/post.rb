class Post < ActiveRecord::Base
  attr_accessible :title, :author, :url, :content, :published_at

  belongs_to :feed

  validates :feed,         presence: true
  validates :title,        presence: true
  validates :author,       presence: true
  validates :url,          presence: true
  validates :content,      presence: true
  validates :published_at, presence: true
end