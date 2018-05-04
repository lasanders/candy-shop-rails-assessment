class Candy < ApplicationRecord
    has_many :purchases
    has_many :users, through: :purchases

    # scope :sweet, -> { where(sweet: true) }
    scope :sweet, -> {where(taste: 'sweet')}
end



