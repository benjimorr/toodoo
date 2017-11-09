class Item < ApplicationRecord
    belongs_to :todo

    validates :name, presence: true, length: { minimum: 5, maximum: 50 }
    validates :todo, presence: true
end
