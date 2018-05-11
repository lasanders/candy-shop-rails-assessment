# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) 
- User has_many purchases, Candy has_many purchases
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) 
- Purchase belongs to User. Purchase belongs to candy
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) 
- User has_many candies through purchases. Candy has many users through purchases
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
- User has many candies through purchases (which is my join table). candy attributes: candy.taste, candy.cost, candy.appetite, candy.name, candy.count
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
- User and candy validations for presence of attributes and values of fields (i.e. integer, text, etc.)
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
Scope methods in user model for 'sweet' and 'sour.' Can see this working in users/new, candy/new, Users/edit, candy/edit
- [x] Include signup (how e.g. Devise)
- Signup link from home page - password encryption using bcrypt
- [x] Include login (how e.g. Devise)
- login link from home page - password encryption using bcrypt
- [x] Include logout (how e.g. Devise)
- logout possible from various pages in app.
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
- Used OmniAuth Google2 for signup/login through google
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
- users/4/candies
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
- Users who are employees, can add new candies by visiting candies/new page
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
candies/new, users/new, candies/edit, users/edit
Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
