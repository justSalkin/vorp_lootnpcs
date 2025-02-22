---@diagnostic disable: undefined-global

local VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

local Inventory = exports.vorp_inventory:vorp_inventoryApi()


RegisterServerEvent('npcloot:give_reward', function(data)
    local _source = source
    local User = VORPcore.getUser(_source)
    local Character = User.getUsedCharacter

    if data ~= 1 then -- change this number acording to  your client side  cheaters can see this so do a new number and in client as well on this event they must match
        return print("cheater detected Id:", _source, GetPlayerName(_source), GetPlayerIdentifiers(_source))
    end

    if not User then
        return
    end

    if Config.canReceiveWeapons then
        local chance = math.random(1, Config.chanceGettingWeapon)
        if chance < Config.receiveWeapon then
            local ammo = { ["nothing"] = 0 }
            local reward1 = Config.weapons
            local chance1 = math.random(1, #reward1)

            Inventory.canCarryWeapons(_source, 1, function(cb)
                if not cb then
                    return VORPcore.NotifyRightTip(_source, Config.Translate.invFullWeapon, 3000)
                end
            end)

            Inventory.createWeapon(_source, Config.weapons[chance1].name, ammo, {})
            if Config.useNotifyRight == true then
                VORPcore.NotifyRightTip(_source, Config.Translate.youGot .. Config.weapons[chance1].label, 3000)
            else
                VORPcore.NotifyLeft(_source, Config.Translate.notifytitle, "" ..Config.Translate.youGot.. "" ..Config.weapons[chance1].label.. "", "BLIPS", "blip_ambient_bounty_target", 3000, "COLOR_GREEN")
            end
        else -- info on finding nothing
            if Config.useNotifyRight == true then
                VORPcore.NotifyRightTip(_source, Config.Translate.noWeapon, 3000)
            else
                VORPcore.NotifyLeft(_source, Config.Translate.notifytitle, "" ..Config.Translate.noWeapon.. "", "BLIPS", "blip_destroy", 3000, "COLOR_RED")
            end
        end
    end

    if Config.canReceiveMoney then
        local chance1 = math.random(1, Config.chanceGettingMoney)
        if chance1 < Config.receiveMoney then
            local item_type = math.random(1, #Config.money)
            Character.addCurrency(0, Config.money[item_type])
            if Config.useNotifyRight == true then
                VORPcore.NotifyRightTip(_source, Config.Translate.youGot .. string.format("%.2f", Config.money[item_type]) .. Config.Translate.currency, 3000)
            else
                VORPcore.NotifyLeft(_source, Config.Translate.notifytitle, Config.Translate.youGot .. string.format("%.2f", Config.money[item_type]) .. Config.Translate.currency, "BLIPS", "blip_ambient_bounty_target", 3000, "COLOR_GREEN")
            end
        else -- info on finding nothing
            if Config.useNotifyRight == true then
                VORPcore.NotifyRightTip(_source, Config.Translate.noMoney, 3000)
            else
                VORPcore.NotifyLeft(_source, Config.Translate.notifytitle, "" ..Config.Translate.noMoney.. "", "BLIPS", "blip_destroy", 3000, "COLOR_RED")
            end
        end
    end


    if Config.canReceiveGold then
        local chance2 = math.random(1, Config.chanceGettingGold)
        if chance2 < Config.receiveGold then
            local item_type = math.random(1, #Config.gold)
            Character.addCurrency(1, Config.gold[item_type])
            if Config.useNotifyRight == true then
                VORPcore.NotifyRightTip(_source, Config.Translate.youGot .. Config.gold[item_type] .. Config.Translate.nugget, 3000)
            else
                VORPcore.NotifyLeft(_source, Config.Translate.notifytitle, Config.Translate.youGot .. Config.gold[item_type] .. Config.Translate.nugget, "BLIPS", "blip_ambient_bounty_target", 3000, "COLOR_GREEN")
            end
        else -- info on finding nothing
            if Config.useNotifyRight == true then
                VORPcore.NotifyRightTip(_source, Config.Translate.noGold, 3000)
            else
                VORPcore.NotifyLeft(_source, Config.Translate.notifytitle, "" ..Config.Translate.noGold.. "", "BLIPS", "blip_destroy", 3000, "COLOR_RED")
            end
        end
    end

    if Config.canReceiveItems then
        local chance3 = math.random(1, Config.chanceGettingItem)
        if chance3 < Config.receiveItem then
            local chance4 = math.random(1, #Config.items)
            local count = 1
            local canCarry = Inventory.canCarryItems(_source, count)                             --can carry inv space
            local canCarry2 = Inventory.canCarryItem(_source, Config.items[chance4].name, count) --cancarry item limit

            if not canCarry then
                return VORPcore.NotifyRightTip(_source, Config.Translate.invFullItems, 30000)
            end

            if not canCarry2 then
                return VORPcore.NotifyRightTip(_source, Config.Translate.ItemsFull .. Config.items[chance4].label, 30000)
            end

            Inventory.addItem(__source, Config.items[chance4].name, count)
            if Config.useNotifyRight == true then
                VORPcore.NotifyRightTip(_source, Config.Translate.youGot .. Config.items[chance4].label, 3000)
            else
                VORPcore.NotifyLeft(_source, Config.Translate.notifytitle, Config.Translate.youGot .. Config.items[chance4].label, "BLIPS", "blip_ambient_bounty_target", 3000, "COLOR_GREEN")
            end

        else -- info on finding nothing
            if Config.useNotifyRight == true then
                VORPcore.NotifyRightTip(_source, Config.Translate.noItem, 3000)
            else
                VORPcore.NotifyLeft(_source, Config.Translate.notifytitle, "" ..Config.Translate.noItem.. "", "BLIPS", "blip_destroy", 3000, "COLOR_RED")
            end
        end
    end
end)