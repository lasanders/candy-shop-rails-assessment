users_features_spec

require_relative "../rails_helper.rb"
describe 'Feature Test: User Signup', :type => :feature do

  it 'successfully signs up as non-employee' do
    visit '/users/new'
    expect(current_path).to eq('/users/new')
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Jane Jones")
    expect(page).to have_content("100")
    expect(page).to have_content("sour")
    expect(page).to have_content("100")
  end

  it "on sign up, successfully adds a session hash" do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'successfully logs in as non-employee' do
    
    # user_login method is defined in login_helper.rb
    create_standard_user
    visit '/signin'
    expect(current_path).to eq('/signin')
    user_login
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Mindy")
    expect(page).to have_content("50")
    expect(page).to have_content("sour")
    expect(page).to have_content("10")
    expect(page).to have_content("125")
  end

  it "on log in, successfully adds a session hash" do
    create_standard_user
    visit '/signin'
    # user_login method is defined in login_helper.rb
    user_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'prevents user from viewing user show page and redirects to home page if not logged in' do
    create_standard_user
    visit '/users/1'
    expect(current_path).to eq('/')
    expect(page).to have_content("Sign Up")
  end

  it 'successfully signs up as employee' do
    visit '/users/new'
    expect(current_path).to eq('/users/new')
    # employee_signup method is defined in login_helper.rb
    employee_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Penny Lane")
    expect(page).to have_content("EMPLOYEE")
  end

  it "on sign up for employee, successfully adds a session hash" do
    visit '/users/new'
    # employee_signup method is defined in login_helper.rb
    employee_signup
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

  it 'successfully logs in as employee' do
    create_standard_and_employee_user
    visit '/signin'
    expect(current_path).to eq('/signin')
    # employee_login method is defined in login_helper.rb
    employee_login
    expect(current_path).to eq('/users/2')
    expect(page).to have_content("Penny")
    expect(page).to have_content("EMPLOYEE")
  end

  it "on log in, successfully adds a session hash to employees" do
    create_standard_and_employee_user
    visit '/signin'
    # employee_login method is defined in login_helper.rb
    employee_login
    expect(page.get_rack_session_key('user_id')).to_not be_nil
  end

end

describe 'Feature Test: User Signout', :type => :feature do

  it 'has a link to log out from the users/show page' do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    expect(page).to have_content("Log Out")
  end

  it 'redirects to home page after logging out' do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    click_link("Log Out")
    expect(current_path).to eq('/')
  end

  it "successfully destroys session hash when 'Log Out' is clicked" do
    visit '/users/new'
    # user_signup method is defined in login_helper.rb
    user_signup
    click_link("Log Out")
    expect(page.get_rack_session).to_not include("user_id")
  end

  it 'has a link to log out from the users/show page when user is an employee' do
    visit '/users/new'
    # employee_signup method is defined in login_helper.rb
    employee_signup
    expect(page).to have_content("Log Out")
  end

  it 'redirects to home page after employee logs out when user is an employee' do
    visit '/users/new'
    # employee_signup method is defined in login_helper.rb
    employee_signup
    click_link("Log Out")
    expect(current_path).to eq('/')
  end

  it "successfully destroys session hash when 'Log Out' is clicked as employee" do
    visit '/users/new'
    # employee_signup method is defined in login_helper.rb
    employee_signup
    click_link("Log Out")
    expect(page.get_rack_session).to_not include("user_id")
  end
end

describe 'Feature Test: Purchase Candy', :type => :feature do

  before :each do
    @sour_skittles = Candy.create(
      :name => "Sour Skittles",
      :taste => "sour",
      :cost => 25,
      :appetite => 25,
    )
    @starburst = Candy.create(
          :name => "Starburst",
      :taste => "sweet",
      :cost => 50,
      :appetite => 50,
    )
    @peanut_butter_cups = Candy.create(
      :name => "Peanut Butter Cups",
      :taste => "sweet",
      :cost => 102,
      :appetite => 102,
    )
    visit '/users/new'
    user_signup
  end

  it 'has a link from the user show page to the candy index page' do
    expect(page).to have_content("Candy Details")
    click_link('Candy Details')
  end

  it 'links from the user show page to the Candy index page' do
    click_link('Candy Details')
    expect(current_path).to eq('/candies')
  end

  it 'prevents users from editing/deleting/adding candies on the index page' do
    click_link('See candies')
    expect(current_path).to eq('/candies')
    expect(page).to_not have_content("edit")
    expect(page).to_not have_content("delete")
    expect(page).to_not have_content("new candy")
  end

  it 'has titles of the candies on the candies index page' do
    click_link('See candies')
    expect(page).to have_content("#{@sour_skittles.name}")
    expect(page).to have_content("#{@starburst.name}")
  end

  it "has links on the candies index page to the candies' show pages" do
    click_link('See candies')
    expect(page).to have_content("Go on #{@sour_skittles.name}")
    expect(page).to have_content("Go on #{@starburst.name}")
  end

  it "links from the candies index page to the candies' show pages" do
    click_link('See candies')
    click_link("Purchase #{@starburst.name}")
    expect(current_path).to eq("/candies/2")
  end

  it 'prevents users from editing/deleting a candy on the show page' do
    click_link('See candies')
    click_link("Purchase #{@starburst.name}")
    expect(page).to_not have_content("edit")
    expect(page).to_not have_content("delete")
  end

  it "has a button from the candy show page to purchase candy" do
    click_link('See candies')
    click_link("Purchase #{@starburst.name}")
    expect(current_path).to eq("/candies/2")
    expect(page).to have_button("Purchase Candy")
  end

  it "clicking on 'Purchase Candy' redirects to user show page" do
    click_link('See candies')
    click_link("Purchase #{@starburst.name}")
    click_button("Purchase Candy")
    expect(current_path).to eq("/users/1")
  end

  it "clicking on 'Purchase Candy' updates the users cash" do
    click_link('See candies')
    click_link("Purchase #{@starburst.name}")
    click_button("Purchase Candy")
    expect(page).to have_content("Cash: 98")
  end

  it "clicking on 'Purchase Candy' updates the users appetite" do
    click_link('See candies')
    click_link("Purchase #{@peanut_butter_cups.name}")
    click_button("Purchase Candy")
    expect(page).to have_content("FEED ME CANDY, STAT")
  end

  it "when the user has enough cash and is hungry enough, clicking on 'Purchase Candy' displays a thank you message" do
    click_link('See candies')
    click_link("Purchase #{@starburst.name}")
    click_button("Purchase")
    expect(page).to have_content("Thanks for purchasing the #{@starburst.name}!")
  end

  it "when the user doesn't have enough cash, clicking on 'Purchase Candy' displays a sorry message" do
    @user = User.find_by(:name => "Jane Jones")
    @user.update(:cash => 10)
    click_link('See candies')
    click_link("Purchase #{@peanut_butter_cups.name}")
    click_button("Purchase Candy")
    expect(page).to have_content("You do not have enough cash to purchase #{@peanut_butter_cups.name}")
  end

  it "when the user is too full, clicking on 'Purchase Candy' displays a sorry message" do
    @user = User.find_by(:name => "Jane Jones")
    @user.update(:cash => 100)
    click_link('See candies')
    click_link("Go on #{@peanut_butter_cups.name}")
    click_button("Purchase Candy")
    expect(page).to have_content("You are too full to purchase #{@peanut_butter_cups.name}")
  end

  it "when the user doesn't have enough cash and is too full, clicking on 'Purchase Candy' displays a detailed sorry message" do
    @user = User.find_by(:name => "Jane Jones")
    @user.update(:cash => 1, :appetite => 30)
    click_link('See candies')
    click_link("Purchase #{@sour_skittles.name}")
    click_button("Purchase candy")
    expect(page).to have_content("You do not have enough cash to purchase #{@starburst.name}")
    expect(page).to have_content("You are too full to purchase #{@starburst.name}")
    expect(page).to have_content("cash: 1")
  end
end

describe 'Feature Test: Employee Flow', :type => :feature do

  before :each do
    @sour_skittles = Candy.create(
      :name => "Sour Skittles",
      :cost => 25,
      :appetite => 25,
      :taste => "sour",
    )
    @starburst = Candy.create(
      :name => "Starburst",
      :cost => 50,
      :appetite => 50,
      :taste => "sweet",
    )
    @peanut_butter_cups = Candy.create(
      :name => "Peanut Butter Cups",
       :cost => 75,
      :appetite => 75,
      :taste => "sweet",
    )
    visit '/users/new'
    employee_signup
  end

  it 'displays employee when logged in as an employee on user show page' do
    expect(page).to have_content("EMPLOYEE")
  end

  it 'links to the candies from the users show page when logged in as a Employee' do
    expect(page).to have_content("See candies")
  end

  it 'has a link from the user show page to the candies index page when in employee mode' do
    click_link('See candies')
    expect(page).to have_content("#{@sour_skittles.name}")
    expect(page).to have_content("#{@starburst.name}")
    expect(page).to have_content("#{@peanut_butter_cups.name}")
  end

  it 'allows employees to add a candy from the index page' do
    click_link('See candies')
    expect(page).to have_content("New Candy")
  end

  it 'allows employees to add a candy' do
    click_link('See candies')
    click_link("New Candy")
    expect(current_path).to eq('/candies/new')
    fill_in("candy[name]", :with => "Gummy Bears")
    fill_in("candy[cost]", :with => "32")
    fill_in("candy[taste]", :with => "sweet")
    fill_in("candy[appetite]", :with => "25")
    click_button('Create Candy')
    expect(current_path).to eq("/candies/4")
    expect(page).to have_content("Gummy Bears")
  end

  it "has link to candies/show from candies/index page for employees" do
    click_link('See candies')
    expect(page).to have_content("See #{@starburst.name}")
  end

  it "does not suggest that Employees purchase candy" do
    click_link('See candies')
    expect(page).to_not have_content("Purchase #{@starburst.name}")
  end

  it "links to candies/show page from candies/index" do
    click_link('See candies')
    click_link("See #{@sour_skittles.name}")
    expect(current_path).to eq("/candies/1")
  end

  it "does not suggest that an employee purchase candy from candies/show page" do
    click_link('See candies')
    click_link("See #{@sour_skittles.name}")
    expect(page).to_not have_content("Purchase Candy")
  end

  it "has a link for employee to edit candy from the candies/show page" do
    click_link('See candies')
    click_link("Show #{@sour_skittles.name}")
    expect(page).to have_content("Edit Candy")
  end

  it "links to candy/edit page from candy/show page when logged in as an employee" do
    click_link('See candies')
    click_link("Show #{@sour_skittles.name}")
    click_link("Edit Candy")
    expect(current_path).to eq("/candies/1/edit")
  end

  it "updates a candy when an employee edits it" do
    click_link('See candies')
    click_link("See #{@sour_skittles.name}")
    click_link("Edit Candy")
    fill_in("candy[name]", :with => "Jolly Ranchers")
    click_button("Update Candy")
    expect(current_path).to eq("/candies/1")
    expect(page).to have_content("Jolly Ranchers")
  end
end