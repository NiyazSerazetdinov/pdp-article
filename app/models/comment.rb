class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :user, :text, :article, presence: true
end
