local Menu

net.Receive("FMenu", function()
    if (Menu == nil) then
        Menu = vgui.Create("DFrame")
        Menu:SetSize(700, 500)
        Menu:SetPos(ScrW() / 2 - 250, ScrH() / 2 - 250)
        Menu:SetTitle("Kupuj")
        Menu:SetDraggable(false)
        Menu:ShowCloseButton(false)
        Menu:SetDeleteOnClose(false)
        Menu.Paint = function()

            surface.SetDrawColor(60, 60, 60, 255)
            surface.DrawRect(0, 0, Menu:GetWide(), Menu:GetTall())
            
            surface.SetDrawColor(40, 40, 40, 255)
            surface.DrawRect(0, 24, Menu:GetWide(), 1)
        end
    end

    addButtons(Menu)

    if (net.ReadBit() == 0) then
        Menu:Hide()
        gui.EnableScreenClicker(false)
    else
        Menu:Show()
        gui.EnableScreenClicker(true)
    end
end)

function addButtons(Menu)

    local playerButton = vgui.Create("DButton")
    playerButton:SetParent(Menu)
    playerButton:SetText("")
    playerButton:SetSize(100, 50)
    playerButton:SetPos(0, 25)
    playerButton.Paint = function()
        surface.SetDrawColor(50, 50, 50, 255)
        surface.DrawRect(0, 0, playerButton:GetWide(), playerButton:GetTall())
        
        surface.SetDrawColor(40, 40, 40, 255)
        surface.DrawRect(0, 49, playerButton:GetWide(), 1)
        surface.DrawRect(99, 0, 1, playerButton:GetTall())

        draw.DrawText("Player", "DermaDefaultBold", playerButton:GetWide() / 2, 17, Color( 255, 255, 255, 255 ), 1)    
    end
    
    playerButton.DoClick = function(playerButton)
        local playerPanel = Menu:Add("playerPanel")

        playerPanel.Paint = function()

        surface.SetDrawColor(50, 50, 50, 255)
        surface.DrawRect(0, 0, playerPanel:GetWide(), playerPanel:GetTall())
        surface.SetTextColor(255, 255, 255, 255)

        --Nazwa
        surface.CreateFont("HeaderFont", {font="Default", size=30, weight=5000})
        surface.SetFont("HeaderFont")
        surface.SetTextPos(5, 0)
        surface.DrawText(LocalPlayer():GetName())

        --Pinondze
        surface.SetFont("Default")
        surface.SetTextPos(8, 35)
        surface.SetTextColor(0, 255, 0, 255)
        surface.DrawText("Pieniądze : ".. LocalPlayer():GetNWInt("playerMoney").. "$")

        end
    end

    local shopButton = vgui.Create("DButton")
    shopButton:SetParent(Menu)
    shopButton:SetText("")
    shopButton:SetSize(100, 50)
    shopButton:SetPos(0, 75)
    shopButton.Paint = function()
        surface.SetDrawColor(50, 50, 50, 255)
        surface.DrawRect(0, 0, shopButton:GetWide(), shopButton:GetTall())
        
        surface.SetDrawColor(40, 40, 40, 255)
        surface.DrawRect(0, 49, playerButton:GetWide(), 1)
        surface.DrawRect(99, 0, 1, playerButton:GetTall())

        draw.DrawText("Shop", "DermaDefaultBold", shopButton:GetWide() / 2, 17, Color( 255, 255, 255, 255 ), 1)    
    end

    shopButton.DoClick = function(shopButton)
        local shopPanel = Menu:Add("shopPanel")

        local entityCategory = vgui.Create("DCollapsibleCategory", shopPanel)
        entityCategory:SetPos(0, 0)
        entityCategory:SetSize(shopPanel:GetWide(), 100)
        entityCategory:SetLabel("Entities")

        local weaponCategory = vgui.Create("DCollapsibleCategory", shopPanel)
        weaponCategory:SetPos(0, 150)
        weaponCategory:SetSize(shopPanel:GetWide(), 100)
        weaponCategory:SetLabel("Weapons")

----------------------------------------------------------------------------------------

        local entityList = vgui.Create("DIconLayout", entityCategory)

        entityList:SetPos(0, 20)
        entityList:SetSize(entityCategory:GetWide(), entityCategory:GetTall())
        entityList:SetSpaceY(5)
        entityList:SetSpaceX(5)

        local weaponList = vgui.Create("DIconLayout", weaponCategory)

        weaponList:SetPos(0, 20)
        weaponList:SetSize(weaponCategory:GetWide(), weaponCategory:GetTall())
        weaponList:SetSpaceY(5)
        weaponList:SetSpaceX(5)

        local entsArr = {}
        entsArr[1] = scripted_ents.Get("ammo_dispenser")

        for k, v in pairs(entsArr) do
            local icon = vgui.Create("SpawnIcon", entityList)
            icon:SetModel(v["Model"])
            icon:SetToolTip(v["PrintName"].. "\nCost: " .. v["Cost"].."$")
            entityList:Add(icon)
            icon.DoClick = function(icon)

                LocalPlayer():ConCommand("buy_entity "..v["ClassName"])

            end
        end

 --mg_mpapa5, mg_glock, mg_p320, mg_mike4, mg_charlie725, mg_dblmg

        local weaponsArr = {}
        weaponsArr[1] = {"models/weapons/w_357.mdl", "weapon_357", ".357 Magnum", "1500"}
        weaponsArr[2] = {"models/weapons/w_mg_akilo47.mdl", "mg_akilo47", "AK-47", "2500"}
        weaponsArr[3] = {"models/weapons/w_mg_mpapa5.mdl", "mg_mpapa5", "MP5", "2300"}
        weaponsArr[4] = {"models/weapons/w_mg_glock.mdl", "mg_glock", "X16", "1600"} 
        weaponsArr[5] = {"models/weapons/w_mg_p320.mdl", "mg_p320", "M19", "1650"} 
        weaponsArr[6] = {"models/weapons/w_mg_mike4.mdl", "mg_mike4", "M4A1", "2600"} 
        weaponsArr[7] = {"models/weapons/w_mg_charlie725.mdl", "mg_charlie725", "725", "1700"} 
        weaponsArr[8] = {"models/weapons/w_mg_dblmg.mdl", "mg_dblmg", "MINI-GUN", "15000"} 

        for k, v in pairs(weaponsArr) do
            local icon = vgui.Create("SpawnIcon", weaponList)
            icon:SetModel(v[1])
            icon:SetToolTip(v[3].. "\nCost: " .. v[4].."$")
            weaponList:Add(icon)
            icon.DoClick = function(icon)

                LocalPlayer():ConCommand("buy_gun "..v[2].. " "..v[4])

            end
        end
    end

    --Player Panel

    PANEL = {}

    function PANEL:Init()
        self:SetSize(650, 475)
        self:SetPos(100, 25)
    end

    function PANEL:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
    end

    vgui.Register("playerPanel", PANEL, "Panel")
    --End player panel

    --Shop Panel

    PANEL = {}

    function PANEL:Init()
        self:SetSize(650, 475)
        self:SetPos(100, 25)
    end

    function PANEL:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 255))
    end

    vgui.Register("shopPanel", PANEL, "Panel")
    --End Shop panel
end