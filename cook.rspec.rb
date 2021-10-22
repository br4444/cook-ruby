require 'rspec'
require_relative './cook'

# Run tests:
# bundle install
# rspec cook.rspec.rb
#
RSpec.describe RecipesReader do
  describe "RecipesReader" do
    context "getIngred" do
      it "ignore not asked recipes" do
        file = CSV.generate do |csv|
          csv << ["菜名", "种类", "食谱", "数量", "单位"]
          csv << ["boulette_ikea", "ingred", "oignon", "1", nil]
          csv << ["tartiflette", "ingred", "lardon", "200", "g"]
        end 
        allow(File).to receive(:open).and_return(file)

        recipesReader = RecipesReader.new "recipe.csv"
        result = recipesReader.getIngred(["boulette_ikea"])

        expected = [["oignon", 1, nil]]
        expect(result).to match_array expected
      end
    end
  end
end