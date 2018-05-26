class Candy < ApplicationRecord
    has_many :purchases
    has_many :users, through: :purchases
    validates_presence_of :name, :taste, :cost, :appetite
    validates :cost, :appetite, :count, numericality: { only_integer: true }
    validates :taste, inclusion: {in: %w(sweet sour), message: ": Please choose sweet or sour" }
    accepts_nested_attributes_for :purchases
 

    scope :sour, -> { where(taste: 'sour') }
    scope :sweet, -> {where(taste: 'sweet')}
    

end



