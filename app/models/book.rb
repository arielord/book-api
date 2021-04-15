class Book < ApplicationRecord
    has_many :book_authors
    has_many :authors, through: :book_authors
    belongs_to :publisher
end
