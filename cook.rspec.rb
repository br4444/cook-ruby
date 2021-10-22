require 'rspec'
require_relative './cook'

# Run tests:
# bundle install
# rspec cook.rspec.rb
#
RSpec.describe RecipesReader do
  describe "RecipesReader" do
    context "getIngred" do
      it "get all ingredients from recipe" do
        mockCSV([
          ["tartiflette", "ingred", "oignon", 2, "pièce"],
          ["tartiflette", "ingred", "lardon", 200, "g"],
        ])

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getIngred(["tartiflette", "boulette_ikea"])

        expected = [
          ["oignon", 2, "pièce"],
          ["lardon", 200, "g"],
        ]
        expect(result).to match_array expected
      end

      it "ignore not asked recipe" do
        mockCSV([
          ["tartiflette", "ingred", "lardon", "200", "g"]
        ])

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getIngred(["not-a-recipe"])

        expected = []
        expect(result).to match_array expected
      end

      it "only select ingredient" do
        mockCSV([
          ["tartiflette", "prep", nil, 1, "peel"],
        ])

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getIngred(["tartiflette"])

        expected = []
        expect(result).to match_array expected
      end

      it "gather same ingredient from different recipes" do
        mockCSV([
          ["tartiflette", "ingred", "oignon", 2, "pièce"],
          ["boulette_ikea", "ingred", "oignon", 1, "pièce"],
        ])

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getIngred(["tartiflette", "boulette_ikea"])

        expected = [["oignon", 3, "pièce"]]
        expect(result).to match_array expected
      end
    end

    context "getPrep" do
      it "order several preparations" do
        mockCSV([
          ["tartiflette", "prep", nil, 3, "boulette", "prepare les boulette"],
          ["tartiflette", "prep", nil, 1, "peel", "eplucher les pdt"],
          ["tartiflette", "prep", nil, 2, "cut", "couper les pdt en 3cm"],
          ["tartiflette", "prep", nil, 2, "brown", "dorer ognion avec beurre"],
        ])

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getPrep(["tartiflette"])

        expected = [
          ["tartiflette", "peel", "eplucher les pdt"],
          ["tartiflette", "cut", "couper les pdt en 3cm"],
          ["tartiflette", "brown", "dorer ognion avec beurre"],
          ["tartiflette", "boulette", "prepare les boulette"],
        ]
        expect(result).to match_array expected
      end

      it "ignore not asked recipe" do
        mockCSV([
          ["tartiflette", "prep", nil, 2, "cut", "couper les pdt en 3cm"],
        ])

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getPrep(["not-a-recipe"])

        expected = []
        expect(result).to match_array expected
      end

      it "only select preparations" do
        mockCSV([
          ["tartiflette", "ingred", "oignon", 2, "pièce"],
        ])

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getPrep(["tartiflette"])

        expected = []
        expect(result).to match_array expected
      end

      it "gather same ingredient from different recipe" do
        mockCSV([
          ["tartiflette", "prep", nil, 2, "cut", "couper les pdt en 3cm"],
          ["boulette_ikea", "prep", nil, 1, "cut", "couper les ognion en petit"],
        ])

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getPrep(["boulette_ikea", "tartiflette"])

        expected = [
          ["boulette_ikea", "cut", "couper les ognion en petit"],
          ["tartiflette", "cut", "couper les pdt en 3cm"],
        ]
        expect(result).to match_array expected
      end
    end
  end
end

def mockCSV(rows)
  file = CSV.generate do |csv|
    csv << ["菜名", "种类", "食谱", "数量", "单位", "步骤"]
    rows.each { |row| csv << row }
  end 
  allow(File).to receive(:open).and_return(file)
end