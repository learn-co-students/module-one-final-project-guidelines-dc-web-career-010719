"Quicker Liquor", a cocktail recipe database/CLI
  - Contributors: Hai Nguyen, Shannon Nabors


Description:
Our program accesses a database of cocktail recipes using the "Cocktail DB" API.
  link: https://www.thecocktaildb.com/api.php
The CLI allows the user to perform a number of functions with the data:
  - The user can create an account and be remembered by the database.
  - The user can see a list of all recipes in the database.
  - The user can search for recipes by name or ingredient.
  - The user can view and edit a "favorites list", which allows them to easily
   access their favorite recipes.
  - The user can view lists of the most popular recipes among all users on the
   database, as well as the most commonly used ingredients.

Install instructions:
  - Fork and clone the directory from the github repository.
    link: https://github.com/hai-nguyen1112/module-one-final-project-guidelines-dc-web-career-010719/tree/development
  - Run "bundle" and then seed the database by running "rake db:migrate" and "rake db:seed".
  - Run "ruby bin/run.rb" to access the CLI.

License:
  - See LICENSE.md
