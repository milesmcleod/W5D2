class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User

  has_many :postings,
    inverse_of: :post,
    dependent: :destroy,
    foreign_key: :post_id,
    primary_key: :id,
    class_name: :PostSub

  has_many :subs,
    through: :postings,
    source: :sub

end
