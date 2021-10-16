import json

class recipe():
    def __init__(self, name, ingredients, preparations, steps, storage):
      #self.id = id
      self.name = name
      self.ingredients = ingredients
      self.preparations = preparations
      self.steps = steps
      self.storage = storage
      
def SumDict(dict1,dict2):
  sumDict = dict1.copy()
  sumDict.update(dict2)
  intersection = set(dict1.keys()) & set(dict2.keys())
  
  for i in intersection:
    for j in dict1:
      if i == j:
        sumDict[i]=(dict2[i][0]+dict1[i][0],dict1[i][1])

  return sumDict

class menu():
    def __init__(self, glucide, meat, vegetal, side_dish):
      self.glucide = glucide
      self.meat = meat
      self.vegetal = vegetal
      self.side_dish = side_dish
    
    def GetListMenu(self):
      return [self.glucide.name, self.meat.name, self.vegetal.name, self.side_dish.name] 

    def SumIngredients(self):
      a=SumDict(self.glucide.ingredients,self.side_dish.ingredients)
      b=SumDict(self.meat.ingredients,self.vegetal.ingredients)      
      sumIngredients=SumDict(a,b)
      return sumIngredients

class weekMenu():
    def __init__(self, listMenu):
      self.monday = listMenu[0]
      self.tuesday = listMenu[1]
      self.wednesday = listMenu[2]
      self.thursday = listMenu[3]
      self.friday = listMenu[4]


f = open("recipe.txt")
lines = f.readlines()
for i in range(len(lines)):
  if lines[i][:7] == "Storage":
    storage = lines[i+1]  
print(storage)
f.close()

boulette_ikea_ingredients={
  "oignon":(1,"na"),
  "viand hacher":(350,"gramme"), 
  "farce":(150,"gramme")
  }
boulette_ikea_preparations={
  "cut":"couper les ognion en petit",
  "brown":"dorer ognion avec beurre",
  "boulette":"prepare les boulette: viand hacher 350g + farce 150g + 1 ognion dore + 40g chapelure + 1/3 cac sel + 1p poivre + 1 cac sucre + 1p muscade + 1 oeuf + 2 cas creme/lait + petit a petit 80ml eau et cube"
  }
boulette_ikea_steps={
  1:"dorer les boulettes",
  2:"sortie les boulettes, faire une sauce: 1 cas beurre + 1 cas farine + 350ml eau tiede avec cube boeuf",
  3:"ajouter boulette dans la sauce + 3 cas de creme"
  }
boulette_ikea = recipe("boulette_ikea",boulette_ikea_ingredients, boulette_ikea_preparations, boulette_ikea_steps, storage)


tartiflette_ingredients={
  "pdt":(800,"gramme"),
  "lardon":(200,"gramme"),
  "oignon":(2,"na"),
  "creme liquide":(100,"ml"),
  "reblochon":(250,"gramme"),
  "vin blanc":(70,"ml")
  }
tartiflette_preparations={
  "peel":"eplucher les pdt",
  "cut":"couper les pdt en 3cm",
  "cut":"couper les oignon en petit",
  "brown":"dorer les lardons et les oignons"
  }
tartiflette_steps={
  1:"mettre 800g pdt en 3cm + lardon 200g dore + 2 oignons dore + creme liquide 100ml + vin blanc 70ml dans la machine, 15min",
  2:"ajouter reblochon laisser tiede pendant 5min"
  }

tartiflette=recipe("tartiflette",tartiflette_ingredients,tartiflette_preparations,tartiflette_steps,"frigo")


riz_ingredients={
  "riz":(100,"gramme")
}
riz_steps={}
riz_preparations={}
riz=recipe("riz",riz_ingredients,riz_preparations,riz_steps,"frigo")


pdt_ingredients={
  "pdt":(100,"gramme")
}
pdt_steps={}
pdt_preparations={}
pdt=recipe("pdt",pdt_ingredients,pdt_preparations,riz_steps,"frigo")

m=menu(riz,tartiflette,boulette_ikea,pdt)
print(m.GetListMenu())
print(riz_ingredients)
print(pdt_ingredients)
print(tartiflette_ingredients)
print(boulette_ikea_ingredients)
print(m.SumIngredients())


f = open("recipe.parquet","a")
f.write("")
f.close()

with open("recipe.json","r") as f:
  jsonDict = json.load(f)

print("--1--")
print(type(jsonDict))
print(jsonDict)
print(jsonDict.keys())
print(type(jsonDict['boulette_ikea']))


