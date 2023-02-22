require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"
require "utils"


local ITEMS_WEIGHT = {
    [".BoxOfSalt"]=4,
    [".Salt"]=1,
}


utils.insertDistribution(ProceduralDistributions.list["BurgerKitchenButcher"], ITEMS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["FishChipsKitchenButcher"], ITEMS_WEIGHT, 4);
utils.insertDistribution(ProceduralDistributions.list["ItalianKitchenButcher"], ITEMS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["JaysKitchenButcher"], ITEMS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["KitchenDryFood"], ITEMS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["MexicanKitchenButcher"], ITEMS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["SeafoodKitchenButcher"], ITEMS_WEIGHT, 3);
utils.insertDistribution(ProceduralDistributions.list["StoreKitchenButcher"], ITEMS_WEIGHT, 2);
utils.insertDistribution(ProceduralDistributions.list["WesternKitchenButcher"], ITEMS_WEIGHT, 2);

utils.insertDistribution(ProceduralDistributions.list["StoreShelfSpices"], ITEMS_WEIGHT, 5);
