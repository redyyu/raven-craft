require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"
require "Vehicles/VehicleDistributions"


local function processDistributionsTable(tableList)
    for k, v in pairs(tableList) do
        if v.items and type(v.items) == 'table' then
            local have_cig = false
            for i=1, #v.items do
                if v.items[i] == 'Cigarettes' then
                    v.items[i] = 'CigarettesPack'
                    have_cig = true
                end
            end
            if have_cig then -- add back cigarettes with lower weight.
                insertDistTable(v, 'Cigarettes', 5)
            end
        end
    end
end


processDistributionsTable(ProceduralDistributions.list)
processDistributionsTable(VehicleDistributions)
processDistributionsTable(SuburbsDistributions.all)

-- Cigarettes

-- insertDistTable(ProceduralDistributions.list["BarCounterMisc"], ITEMS_WEIGHT, 5)
-- insertDistTable(ProceduralDistributions.list["CrateCigarettes"], ITEMS_WEIGHT, 20)
-- insertDistTable(ProceduralDistributions.list["DeskGeneric"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["DrugShackDrugs"], ITEMS_WEIGHT, 5)
-- insertDistTable(ProceduralDistributions.list["DrugShackMisc"], ITEMS_WEIGHT, 5)
-- insertDistTable(ProceduralDistributions.list["GasStorageCombo"], ITEMS_WEIGHT, 10)
-- insertDistTable(ProceduralDistributions.list["JanitorMisc"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["KitchenRandom"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["MechanicShelfMisc"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["OfficeDesk"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["OfficeDeskHome"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["OtherGeneric"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["PlankStashGun"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["PlankStashMagazine"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["PlankStashMoney"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["PoliceDesk"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["PrisonCellRandom"], ITEMS_WEIGHT, 2)

-- insertDistTable(ProceduralDistributions.list["RandomFiller"], ITEMS_WEIGHT, 2)
-- insertDistTable(ProceduralDistributions.list["StoreCounterTobacco"], ITEMS_WEIGHT, 25)

-- insertDistTable(VehicleDistributions.GloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.SurvivalistGlovebox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.FishermanGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.GolfGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.CarpenterGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.ElectricianGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.FarmerGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.MetalWelderGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.DoctorGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.RadioGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.PainterGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.ConstructionWorkerGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.PoliceGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.RangerGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.FireGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.McCoyGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.HunterGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.FossoilGloveBox , ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.PostalGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.SpiffoGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.MassGenFacGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.TransitGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.DistilleryGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.HeraldsGloveBox, ITEMS_WEIGHT, 2)
-- insertDistTable(VehicleDistributions.AmbulanceGloveBox, ITEMS_WEIGHT, 2)


-- insertDistTable(SuburbsDistributions.all.inventoryfemale, ITEMS_WEIGHT, 0.05)
-- insertDistTable(SuburbsDistributions.all.inventorymale, ITEMS_WEIGHT, 0.05)
-- insertDistTable(SuburbsDistributions.all.Outfit_ArmyCamoDesert, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_ArmyCamoGreen, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Bandit, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Biker, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_ConstructionWorker, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Cook_Generic, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Cook_Spiffos, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Foreman, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Fossoil, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Gas2Go, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Ghillie, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Hobbo, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Inmate, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_InmateKhaki, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_McCoys, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Punk, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Raider, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Redneck, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Rocker, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_ThunderGas, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Varsity, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Waiter_Diner, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Waiter_Market, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Waiter_PileOCrepe, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Waiter_PizzaWhirled, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Waiter_Restaurant, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Waiter_Spiffo, ITEMS_WEIGHT, 2)
-- insertDistTable(SuburbsDistributions.all.Outfit_Waiter_TacoDelPancho, ITEMS_WEIGHT, 2)


