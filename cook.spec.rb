require 'test/unit'
require_relative './cook'

class CookTest < Test::Unit::TestCase
  def test_getIngred
    result = getIngred(["boulette_ikea", "tartiflette"])

    expected = [
      ["oignon", 3, nil],
      ["viand hacher", 350, "g"],
      ["farce", 150, "g"],
      ["pdt", 800, "g"],
      ["lardon", 200, "g"],
      ["creme liquide", 100, "ml"],
      ["reblochon", 250, "g"],
      ["vin blanc", 70, "ml"]
    ]
    assert_array_equal expected, result
  end

  def test_getPrep
    result = getPrep(["boulette_ikea", "tartiflette"])

    expected = [
      ["tartiflette", "peel", "eplucher les pdt"],
      ["tartiflette", "cut", "couper les pdt en 3cm"],
      ["tartiflette", "cut", "couper les oignon en petit"],
      ["boulette_ikea", "cut", "couper les ognion en petit"],
      ["tartiflette", "brown", "dorer les lardons et les oignons"],
      ["boulette_ikea", "brown", "dorer ognion avec beurre"],
      ["boulette_ikea", "boulette", "prepare les boulette: viand hacher 350g + farce 150g + 1 ognion dore + 40g chapelure + 1/3 cac sel + 1p poivre + 1 cac sucre + 1p muscade + 1 oeuf + 2 cas creme/lait + petit a petit 80ml eau et cube"]
    ]
    assert_array_equal expected, result
  end
end

def assert_array_equal(expected, actual)
  assert_equal expected.length, actual.length

  expected.each_with_index do |item, index|
    assert_equal item, actual[index]
  end
end