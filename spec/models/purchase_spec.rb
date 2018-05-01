require 'rails_helper'

RSpec.describe Ride, :type => :model do
  let(:candy) {
    Candy.create(
      :name => "Sour Skittles",
      :taste => "sour",
      :cost => 25,
      :appetite => 25,
      )
  }

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

  let(:purchase) {
    Purchase.create(user_id: user.id, candy_id: candy.id)
  }

  it "is valid with a user_id and a candy_id" do
    expect(purchase).to be_valid
  end

  it "belongs to one candy" do
    expect(purchase.candy).to eq(purchase)
  end

  it "belongs to one user" do
    expect(purchase.user).to eq(user)
  end

  it "has a method 'cash_issue' that accounts for the user not having enough cash" do
    purchase = Purchase.create(:user_id => user.id, :purchase_id => purchase.id)
    expect(purchase.purchase_candy).to eq("Sorry. You do not have enough cash to buy the #{candy.name}.")
    expect(user.cash).to eq(10)
    expect(user.taste).to eq("sour")
    expect(user.appetite).to eq(80)
  end

  it "has a method 'purchase_candy' that accounts for the user not being hungry enough" do
    user.update(:cash => 100, :appetite => 80)
    purchase = Purchase.create(:user_id => user.id, :purchase_id => purchase.id)
    expect(purchase.purchase_candy).to eq("Sorry. You are not hungry enough to buy the #{candy.name}.")
    expect(user.cash).to eq(10)
    expect(user.taste).to eq("sour")
    expect(user.nausea).to eq(80)
  end

  it "has a method 'purchase_candy' that accounts for the user not being hungry enough and not having enough cash" do
    user.update(:taste => "sour")
    purchase = Purchase.create(:user_id => user.id, :purchase_id => purchase.id)
    expect(purchase.purchase_candy).to eq("Sorry. You do not have enough cash to buy the #{candy.name}.Sorry. You are not hungry enough to buy the #{candy.name}.")
    expect(user.cash).to eq(10)
    expect(user.taste).to eq("sour")
    expect(user.nausea).to eq(80)
  end

  it "has a method 'purchase_candy' that updates cash amount" do
    user.update(:cash => 10)
    Purchase = Purchase.create(:user_id => user.id, :purchase_id => purchase.id)
    purchase.purchase_candy
    claire = User.find_by(:name => "claire")
    expect(claire.cash).to eq(5)
  end

  it "has a method 'purchase_candy' that updates the user's taste" do
    user.update(:taste => "sour")
    Purchase = Purchase.create(:user_id => user.id, :purchase_id => purchase.id)
    purchase.purchase_candy
    claire = User.find_by(:name => "claire")
    expect(claire.taste).to eq("sweet")
  end

end
