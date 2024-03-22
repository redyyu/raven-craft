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
                RC.insertDistTable(v, 'Cigarettes', 1)
            end
        end
    end
end


processDistributionsTable(ProceduralDistributions.list)
processDistributionsTable(VehicleDistributions)
processDistributionsTable(SuburbsDistributions.all)

-- Cigarettes

-- RC.insertDistTable(ProceduralDistributions.list["BarCounterMisc"], ITEMS_WEIGHT, 5)
-- RC.insertDistTable(ProceduralDistributions.list["CrateCigarettes"], ITEMS_WEIGHT, 20)
-- RC.insertDistTable(ProceduralDistributions.list["DeskGeneric"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["DrugShackDrugs"], ITEMS_WEIGHT, 5)
-- RC.insertDistTable(ProceduralDistributions.list["DrugShackMisc"], ITEMS_WEIGHT, 5)
-- RC.insertDistTable(ProceduralDistributions.list["GasStorageCombo"], ITEMS_WEIGHT, 10)
-- RC.insertDistTable(ProceduralDistributions.list["JanitorMisc"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["KitchenRandom"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["MechanicShelfMisc"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["OfficeDesk"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["OfficeDeskHome"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["OtherGeneric"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["PlankStashGun"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["PlankStashMagazine"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["PlankStashMoney"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["PoliceDesk"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["PrisonCellRandom"], ITEMS_WEIGHT, 2)

-- RC.insertDistTable(ProceduralDistributions.list["RandomFiller"], ITEMS_WEIGHT, 2)
-- RC.insertDistTable(ProceduralDistributions.list["StoreCounterTobacco"], ITEMS_WEIGHT, 25)

-- RC.insertDistTable(VehicleDistributions.GloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.SurvivalistGlovebox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.FishermanGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.GolfGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.CarpenterGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.ElectricianGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.FarmerGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.MetalWelderGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.DoctorGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.RadioGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.PainterGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.ConstructionWorkerGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.PoliceGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.RangerGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.FireGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.McCoyGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.HunterGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.FossoilGloveBox , ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.PostalGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.SpiffoGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.MassGenFacGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.TransitGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.DistilleryGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.HeraldsGloveBox, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(VehicleDistributions.AmbulanceGloveBox, ITEMS_WEIGHT, 2)


-- RC.insertDistTable(SuburbsDistributions.all.inventoryfemale, ITEMS_WEIGHT, 0.05)
-- RC.insertDistTable(SuburbsDistributions.all.inventorymale, ITEMS_WEIGHT, 0.05)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_ArmyCamoDesert, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_ArmyCamoGreen, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Bandit, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Biker, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_ConstructionWorker, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Cook_Generic, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Cook_Spiffos, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Foreman, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Fossoil, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Gas2Go, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Ghillie, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Hobbo, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Inmate, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_InmateKhaki, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_McCoys, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Punk, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Raider, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Redneck, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Rocker, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_ThunderGas, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Varsity, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Waiter_Diner, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Waiter_Market, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Waiter_PileOCrepe, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Waiter_PizzaWhirled, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Waiter_Restaurant, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Waiter_Spiffo, ITEMS_WEIGHT, 2)
-- RC.insertDistTable(SuburbsDistributions.all.Outfit_Waiter_TacoDelPancho, ITEMS_WEIGHT, 2)


