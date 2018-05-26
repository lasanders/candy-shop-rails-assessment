require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) {
    User.create(
      :name => "claire",
      :password => "password",
      :taste => "sweet",
      :cash => 32,
      :appetite => 25,
      :employee => false
    )
  }

  let(:employee) {
    User.create(
      :name => "joe",
      :password => "password",
      :taste => "sour",
      :cash => 65,
      :appetite => 50,
      :employee => true
    )
  }

  let(:sour_skittles) {
    Candy.create(
      :name => "Sour Skittles",
      :taste => "sour",
      :cost => 25,
      :appetite => 25
    )
  }

  let(:starburst) {
    Attraction.create(
      :name => "Starburst",
      :taste => "sweet",
      :cost => 50,
      :appetite => 50,
      )
  }
  let(:peanut_butter_cups) {
    Attraction.create(
      :name => "Peanut Butter Cups",
      :taste => "sweet",
      :cost => 98,
      :appetite => 98,
    )
  }
  it "is valid with a name, password, taste, cost, and appetite" do
    expect(user).to be_valid
  end

  it "is not valid without a password" do
    expect(User.new(name: "Name")).not_to be_valid
  end

  it "is valid with an employee boolean" do
    expect(employee).to be_valid
  end

  it "defaults to employee => false" do
    expect(user.employee).to eq(false)
  end

  it "has many purchases" do
    first_purchase = Purchase.create(:user_id => user.id, :candy_id => sour_skittles.id)
    second_purchase = Purchase.create(:user_id => user.id, :candy_id => starburst.id)
    expect(user.purchases.first).to eq(first_purchase)
    expect(user.purchases.last).to eq(second_purchase)
  end

  it "has many candies through purchases" do
    user.candies << [sour_skittles, starburst, peanut_butter_cups]
    expect(user.candies.first).to eq(sour_skittles)
    expect(user.candies.last).to eq(peanut_butter_cups)
  end

  it "has a method 'hunger' that returns 'I'm too full for candy!' when the user's hunger is between 0-25" do
    expect(user.mood).to eq("I'm too full for candy!")
  end

  it "has a method 'hunger' that returns 'Maybe just a few more pieces!' when the user's hunger is between 25-50" do
    expect(user.mood).to eq("Maybe just a few more pieces!")
  end

end
