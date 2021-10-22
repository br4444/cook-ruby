require 'csv'

class Menu
   def initialize(glucide, meat, vegetal, side_dish)
      @cust_glucide=glucide
      @cust_meat=meat
      @cust_vegetal=vegetal
      @cust_side_dish=side_dish
   end

   def list_achat
      return 1
   end
end

lundi = Menu.new("a","boulette_ikea","c","d")

class RecipesReader
  def initialize(filename)
    @table = CSV.open(filename, headers: true).each.to_a
  end

  def getIngred(recipes)
    return @table
      .select { |row| recipes.include?(row["菜名"]) && row["种类"] == "ingred" }
      .group_by { |row| row["食谱"] }
      .map { |key,value| [
        key,
        value.inject(0){|sum,x| sum + x.field("数量").to_i}, 
        value[0].field("单位")
      ]}
  end

  def getPrep(recipes)
    prep_order = ["peel","cut","brown","boulette"]
    return @table
      .select { |row| recipes.include?(row["菜名"]) && row["种类"] == "prep" }
      .sort_by { |row| prep_order.find_index(row.field("单位")) }
      .map { |row| row.fields("菜名","单位","步骤") }
  end
end

# recipesReader = RecipesReader.new "recipe.csv"

# ingred = recipesReader.getIngred(["boulette_ikea", "tartiflette"])
# ingred.each do |a|
#   print a
#   puts ""
# end

# prep = recipesReader.getPrep(["boulette_ikea", "tartiflette"])
# prep.each do |a|
#   print a
#   puts ""
# end
