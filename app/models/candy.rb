class Candy < ApplicationRecord
    has_many :purchases
    has_many :users, through: :purchases

    scope :sour, -> { where(taste: 'sour') }
    scope :sweet, -> {where(taste: 'sweet')}
end



