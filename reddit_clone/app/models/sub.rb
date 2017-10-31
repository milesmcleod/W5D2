class Sub < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :moderator,
    foreign_key: :moderator_id,
    primary_key: :id,
    class_name: :User

  has_many :posts,
    foreign_key: :sub_id,
    primary_key: :id,
    class_name: :Post

end
