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


def getIngred(recipes)
  table = CSV.open("recipe.csv", headers: true).each.to_a
  return table
    .select { |row| recipes.include?(row["菜名"]) && row["种类"] == "ingred" }
    .group_by {|row| row["食谱"]}
    .map {|key,value| [
      key,
      value.inject(0){|sum,x| sum + x.field("数量").to_i}, 
      value[0].field("单位")
    ]}
end


def getPrep(recipes)
  table = CSV.open("recipe.csv", headers: true).each.to_a
  ord=["peel","cut","brown","boulette"]
  return table
    .select{ |row| recipes.include?(row["菜名"]) && row["种类"] == "prep" }
    .sort{ |a,b| ord.find_index(a.field("单位")) <=> ord.find_index(b.field("单位"))}
    .map {|row| row.fields("菜名","单位","步骤")}

end

ingred = getIngred(["boulette_ikea", "tartiflette"])
prep = getPrep(["boulette_ikea", "tartiflette"])
prep.each do |a|
  print a
  puts ""
end
