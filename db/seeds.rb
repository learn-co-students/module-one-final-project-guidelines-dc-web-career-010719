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
        ing = Ingredient.create(name: ings[index])
        rec.add_ingredient(ing, ams[index])
      end
    end
  end
end

populate(drinks)
