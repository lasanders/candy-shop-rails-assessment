require 'rails_helper'

RSpec.describe Candy, :type => :model do
  let(:candy) {
    Candy.create(
      :name => "Sour Skittles",
      :taste => "sour",
      :cost => 25,
      :appetite => 25,
      )
  }

  it "is valid with a name, cost, taste, and appetite" do
    expect(candy).to be_valid
  end

  it "has many purchases" do
    user = User.create(name: "Carl Marx", password: "password")
    purchase = Purchase.create(user_id: user.id, candy_id: candy.id)
    expect(candy.purchases.first).to eq(purchase)
  end

  it "has many users through purchases" do
    daisy = User.create(name: "Daisy Duke", password: "password")
    jane = User.create(name: "Jane Jackson", password: "password")
    candy.users << [daisy, jane]

    expect(candy.users.first).to eq(daisy)
    expect(candy.users.last).to eq(jane)
  end

end
