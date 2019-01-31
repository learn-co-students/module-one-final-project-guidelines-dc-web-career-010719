require 'rest-client'
require 'json'
require 'pry'

def get_from_api(string)
  s = RestClient.get(string)
  JSON.parse(s)
end

urls = ["https://www.thecocktaildb.com/api/json/v1/1/search.php?s=",
        "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=gin",
        "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=vodka"]

# hashes = urls.map {|url| get_from_api(url)}
hash1 = get_from_api(urls[0])
hash2 = get_from_api(urls[1])
hash3 = get_from_api(urls[2])

def populate(array)
  array.each do |hash|
    rec = Recipe.create(name: hash["strDrink"], instruction: hash["strInstructions"])
    ings = []
    ams = []
    hash.each do |k, v|
      # binding.pry
      if k.to_s.include?("Ingredient")
        ings << v
      elsif k.to_s.include?("Measure")
        ams << v
      end
    end
    ings.each_with_index do |ing, index|
      if !ings[index].nil?
        if !ings[index].empty?
          ing = Ingredient.find_or_create_by(name: ings[index].split(" ").map(&:capitalize).join(" "))
          rec.add_ingredient(ing, ams[index])
        end
      end
    end
  end
end

populate(hash1["drinks"])
populate(hash2["drinks"])
populate(hash3["drinks"])

# hashes.each {|hash| populate(hash["drinks"])}

mod1 = %w(Shannon Hai Matt James Paul Melanie Jake Kyle Artem Chris Ben Ryan Andrea Heloise Phil Chine Ross Anthony Serven)

def create_users(array)
  array.each {|name| User.find_or_create_by(name:name)}
end

create_users(mod1)

def seed_with_favorites
  User.all.each do |user|
    nums = Array.new(rand(1..10)).map{|n|rand(1..Recipe.all.size)}
    nums.uniq.each {|n| user.add_to_favorites(Recipe.find(n))}
  end
end

seed_with_favorites
