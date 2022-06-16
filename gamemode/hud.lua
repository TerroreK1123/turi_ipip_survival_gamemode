
function hud()
    local client = LocalPlayer()

    if !client:Alive() then
        return
    end

   -- Zaczynamy rysować hud


    -- Zdrowie ITP
    draw.RoundedBox(4.6, 0, ScrH() - 100, 250, 100, Color(30, 30, 30, 230))

    draw.SimpleText("Zdrowie : "..client:Health().."%", DermaDefaultBold, 10, ScrH() - 90, Color(255, 255, 255, 255), 0, 0)
    draw.RoundedBox(2.6, 10, ScrH() - 75, 100 * 2.25, 15, Color(225, 0, 0, 80))
    draw.RoundedBox(2.6, 10, ScrH() - 75, math.Clamp(client:Health(), 0, 100) * 2.25, 15, Color(245, 0, 0, 255))
    draw.RoundedBox(2.6, 10, ScrH() - 75, math.Clamp(client:Health(), 0, 100) * 2.25, 5, Color(245, 30, 30, 255))

    draw.SimpleText("Zbroja : "..client:Armor().."%", DermaDefaultBold, 10, ScrH() - 55, Color(255, 255, 255, 255), 0, 0)
    draw.RoundedBox(2.6, 10, ScrH() - 40, 100 * 2.25, 15, Color(0, 250, 255, 45))
    draw.RoundedBox(2.6, 10, ScrH() - 40, math.Clamp(client:Armor(), 0, 100) * 2.25, 15, Color(0, 250, 255, 255))   
    draw.RoundedBox(2.6, 10, ScrH() - 40, math.Clamp(client:Armor(), 0, 100) * 2.25, 5, Color(50, 250, 255, 255))

    --Ammo ITP

    draw.RoundedBox(4.6, ScrW() - 250, ScrH() - 100, 250, 100, Color(30, 30, 30, 230))

    if (client:GetActiveWeapon():GetPrintName() != nil) then
        draw.SimpleText(client:GetActiveWeapon():GetPrintName(), "DermaDefaultBold", ScrW() - 235, ScrH() - 90, Color(255, 255, 255, 255), 0, 0)
    end

    local color_inmag = Color(255, 255, 255, 255)
    local color_rest = Color(255, 255, 255, 255)

    if (client:GetActiveWeapon():Clip1() < 6) then
        color_inmag = Color(255, 5, 5, 255)
    end

    if (client:GetActiveWeapon():Clip1() > 6) then
        color_inmag = Color(255, 255, 255, 255)
    end

    if (client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) < 20) then
        color_rest = Color(255, 5, 5, 255)
    end

    if (client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) > 20) then
        color_rest = Color(255, 255, 255, 255)
    end

    if (client:GetActiveWeapon():Clip1() != -1) then
        draw.SimpleText("Magazynek: "..client:GetActiveWeapon():Clip1(), "DermaDefaultBold", ScrW() - 235, ScrH() - 70, color_inmag, 0, 0)
    end

    if (client:GetActiveWeapon():GetPrimaryAmmoType() != -1) then
        draw.SimpleText("Zapas: "..client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "DermaDefaultBold", ScrW() - 235, ScrH() - 50, color_rest, 0, 0)
    end

    --Mone LOL

    draw.RoundedBox(4.6, ScrW() - 250, ScrH() - 155, 250, 50, Color(30, 30, 30, 230))

    draw.SimpleText("Pieniądze: "..client:GetNWInt("playerMoney").."$", "DermaDefaultBold", ScrW() - 235, ScrH() - 145, Color(0, 255, 0, 255), 0, 0)

end
hook.Add("HUDPaint", "MainHUD", hud)

function hideHud(HudName)
    
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
        if HudName == v then
            return false
        end
    end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", hideHud)