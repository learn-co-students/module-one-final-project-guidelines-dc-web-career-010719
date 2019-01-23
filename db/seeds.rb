drinks = [
  {
    name: "Margarita",
    instruction: "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.",
    ingredient1: "tequila",
    ingredient2: "triple sec",
    ingredient3: "lime juice",
    ingredient4: "salt",
    ingredient5: "",
    amount1: "1.5 oz",
    amount2: "1 oz",
    amount3: "0.5 oz",
    amount4: "",
    amount5: "",
  },
  {
    name: "Blue Margarita",
    instruction: "Rub rim of cocktail glass with lime juice. Dip rim in coarse salt. Shake tequila, blue curacao, and lime juice with ice, strain into the salt-rimmed glass, and serve.",
    ingredient1: "tequila",
    ingredient2: "blue curacao",
    ingredient3: "lime juice",
    ingredient4: "salt",
    ingredient5: "",
    amount1: "1.5 oz",
    amount2: "1 oz",
    amount3: "1 oz",
    amount4: "Coarse",
    amount5: "",
  },
  {
    name: "Whitecap Margarita",
    instruction: "Place all ingredients in a blender and blend until smooth. This makes one drink.",
    ingredient1: "ice",
    ingredient2: "tequila",
    ingredient3: "cream of coconut",
    ingredient4: "lime juice",
    ingredient5: "",
    amount1: "1 cup",
    amount2: "2 oz",
    amount3: "0.25 cups",
    amount4: "3 tbsp fresh",
    amount5: "",
  },
  {
    name: "Martini",
    instruction: "Straight: Pour all ingredients into mixing glass with ice cubes. Stir well. Strain in chilled martini cocktail glass. Squeeze oil from lemon peel onto the drink, or garnish with olive.",
    ingredient1: "gin",
    ingredient2: "dry vermouth",
    ingredient3: "olive",
    ingredient4: "",
    ingredient5: "",
    amount1: "1 2/3 oz",
    amount2: "1/3 oz",
    amount3: "1",
    amount4: "",
    amount5: "",
  },
  {
    name: "Vodka Martini",
    instruction: "Shake the vodka and vermouth together with a number of ice cubes, strain into a cocktail glass, add the olive and serve.",
    ingredient1: "vodka",
    ingredient2: "tequila",
    ingredient3: "dry vermouth",
    ingredient4: "olive",
    ingredient5: "",
    amount1: "1.5 oz",
    amount2: "0.75 oz",
    amount3: "1",
    amount4: "",
    amount5: "",
  }
]

def populate(array)
  array.each do |hash|
    rec = Recipe.create(name: hash[:name], instruction: hash[:instruction])
    ings = []
    ams = []
    hash.each do |k, v|
      if k.to_s.include?("ingredient")
        ings << v
      elsif k.to_s.include?("amount")
        ams << v
      end
    end
    ings.each_with_index do |ing, index|
      if !ings[index].empty?
        ing = Ingredient.find_or_create_by(name: ings[index])
        rec.add_ingredient(ing, ams[index])
      end
    end
  end
end

populate(drinks)

mod1 = %w(Shannon, Hai, Matt, James, Paul, Melanie, Jake, Kyle, Artem, Chris, Ben, Ryan, Andrea, Heloise, Phil)

def create_users(array)
  array.each {|name| User.find_or_create_by(name:name)}
end

create_users(mod1)

def seed_with_favorites
  User.all.each do |user|
    nums = Array.new(rand(1..5)).map{|n|rand(1..5)}
    nums.uniq.each {|n| user.add_to_favorites(Recipe.find(n))}
  end
end

seed_with_favorites
