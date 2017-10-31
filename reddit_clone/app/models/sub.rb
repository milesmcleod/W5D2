class Sub < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :moderator,
    foreign_key: :moderator_id,
    primary_key: :id,
    class_name: :User

  has_many :postings,
    inverse_of: :sub,
    dependent: :destroy,
    foreign_key: :sub_id,
    primary_key: :id,
    class_name: :PostSub

  has_many :posts,
    through: :postings,
    source: :post

end
