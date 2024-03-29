-- 0.2.3
util.toast("Welcome to AnnoyScript. You're now a cool kid")
util.require_natives(1651208000)

local function request_control(entity)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        util.yield()
    end
end

local function player(pid)
    local detections = { "Being too awesome", "AnnoyScript developer", "Rockstar CEO (leave session immediately)" }
    if players.get_rockstar_id(pid) == 211749254 then -- thanks for the idea, Prism
        util.toast(players.get_name(pid) .. " triggered a detection: " .. detections[math.random(#detections)])
    end
    menu.divider(menu.player_root(pid), "AnnoyScript")
    local annoying_stuff = menu.list(menu.player_root(pid), "Annoying Stuff", {}, "")
    local trolling_stuff = menu.list(menu.player_root(pid), "Trolling Stuff", {}, "")
    local vehicle_stuff = menu.list(menu.player_root(pid), "Vehicle Stuff", {}, "")
    local hvh_stuff = menu.list(menu.player_root(pid), "HVH Stuff", {}, "")
    menu.toggle_loop(annoying_stuff, "Message Spam", { "txtspam" }, "Spams the player with troll texts and sound effects.", function()
        util.trigger_script_event(1 << pid, { -791892894, pid, 5423258964353897800, 844318034 })
    end)
    menu.toggle_loop(annoying_stuff, "Harmless Explosion Loop", { "harmlessbombloop" }, "Loops a harmless explosion near the player.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        local explosions = { 26, 32, 36, 38, 59 }
        for explosion = 0, #explosions do
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, explosions[explosion], 0, true, false, 1, false)
        end
    end)
    menu.toggle_loop(annoying_stuff, "Annoying Loop", { "annoyingloop" }, "Loops a bunch of annoying stuff near the player.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        local explosions = { 38, 63, 65, 70 }
        for explosion = 0, #explosions do
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, explosions[explosion], 0, true, false, 1, false)
        end
    end)
    menu.toggle_loop(annoying_stuff, "Ear Rape v1", { "earrape1" }, "Ear rape the player.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        for _ = 0, 100 do
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Horn", pos.x, pos.y, pos.z, "DLC_Apt_Yacht_Ambient_Soundset", true, 1)
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "LOSER", pos.x, pos.y, pos.z, "HUD_AWARDS", true, 1)
        end
        util.yield(1000)
    end)
    menu.toggle_loop(annoying_stuff, "Ear Rape v2", { "earrape2" }, "Ear rape the player using another fun sound.", function()
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
            for _ = 0, 100 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", pos.x, pos.y, pos.z, "WastedSounds", true, 1)
            end
        end)
    menu.action(annoying_stuff, "Stop All Sounds", { "stopsounds" }, "Stops all the sounds (to counter ear-rape), pretty self explanatory.", function()
        for i = 0, 100 do
            AUDIO.STOP_SOUND(i)
            AUDIO.RELEASE_SOUND_ID(i)
        end
    end)
    menu.action(annoying_stuff, "Harass", { "harass" }, "Harass the player.", function()
        util.trigger_script_event(1 << pid, { -791892894, pid, 6868639604984336963, 5657426 })
        util.trigger_script_event(1 << pid, { -791892894, pid, 5497007645930637648, 83 })
        util.trigger_script_event(1 << pid, { -791892894, pid, 90457721034051 })
        util.trigger_script_event(1 << pid, { -791892894, pid, 3472943069862776133, 51 })
    end)
    menu.toggle_loop(trolling_stuff, "Fake Cash Drop", { "fakemoney" }, "Gives the player a fake cash drop, getting their hopes and dreams up. At least until they decide to check their balance.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        if not STREAMING.IS_MODEL_VALID(2628187989) then
            util.yield()
        end
        STREAMING.REQUEST_MODEL(2628187989)
        local cash = OBJECT.CREATE_OBJECT_NO_OFFSET(2628187989, pos.x, pos.y, pos.z + 1.5)
        ENTITY.APPLY_FORCE_TO_ENTITY(cash, 1, 0, 0, -2.0, 0.0, 0.0, 0.0, true, true)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", pos.x, pos.y, pos.z, "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", true, 1)
        menu.trigger_commands("notifybanked" .. players.get_name(pid) .. " 500000")
        util.yield(300)
        entities.delete(cash)
    end)
    menu.action(trolling_stuff, "Box Player", { "boxplayer" }, "Boxes the player up for easy shipment to China.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        if not STREAMING.IS_MODEL_VALID(1765283457) then
            util.yield()
        end
        STREAMING.REQUEST_MODEL(1765283457)
        OBJECT.CREATE_OBJECT_NO_OFFSET(1765283457, pos.x, pos.y, pos.z - 1, true, false, false)
    end)
    menu.action(trolling_stuff, "Mime Player", { "mimeplayer" }, "Same as box player, only this one is invisible.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        if not STREAMING.IS_MODEL_VALID(1765283457) then
            util.yield()
        end
        STREAMING.REQUEST_MODEL(1765283457)
        local box = OBJECT.CREATE_OBJECT_NO_OFFSET(1765283457, pos.x, pos.y, pos.z - 1, true, false, false)
        ENTITY.SET_ENTITY_VISIBLE(box, false)
    end)
    menu.action(trolling_stuff, "Send To Island", { "sendisland" }, "Ships the player off to Cayo Perico.", function()
        util.trigger_script_event(1 << pid, { 1214823473, pid, 0, 0, 4, 1, 0 })
    end)
    menu.action(trolling_stuff, "Send Chris Formage", { "sendchris" }, "Sends Chris Formage to blast the player into outer space.", function()
        if not STREAMING.IS_MODEL_VALID(678319271) then
            util.yield()
        end
        STREAMING.REQUEST_MODEL(678319271)
        for _ = 1, 10 do
            local chris = entities.create_ped(28, 678319271, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)), math.random(0, 270))
            TASK.TASK_COMBAT_PED(chris, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), 0, 16)
            PED.SET_PED_AS_COP(chris, true)
            WEAPON.GIVE_WEAPON_TO_PED(chris, 2939590305, 0, false, true)
        end
    end)
    menu.action(vehicle_stuff, "Send Vehicle Flying", { "launchv" }, "Sends the player's vehicle flying.", function()
        request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false))
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)) then
            for _ = 0, 10 do
                ENTITY.APPLY_FORCE_TO_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false), 2, 0, 0, 10000, 0, 0, 0, 0, true, false, true, false, true)
            end
        else
            util.toast("Could not get control of vehicle.")
        end
    end)
    menu.action(vehicle_stuff, "Make Them Crash", { "crashcar" }, "Makes the player crash their car.", function()
        request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false))
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)) then
            for _ = 0, 10 do
                ENTITY.APPLY_FORCE_TO_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false), 2, 1000, 0, 0, 0, 0, 0, 0, true, false, true, false, true)
            end
        else
            util.toast("Could not get control of vehicle.")
        end
    end)
    menu.action(vehicle_stuff, "Kill Engine", { "killengine" }, "Kills the engine of the player's vehicle.", function()
            request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true))
            if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)) then
                VEHICLE.SET_VEHICLE_ENGINE_HEALTH(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true), -4000.0)
            else
                util.toast("Could not get control of vehicle.")
            end
        end)
    menu.action(vehicle_stuff, "Kick From Vehicle", { "vehiclekick" }, "Kicks the player out of their vehicle.", function()
            util.trigger_script_event(1 << pid, { -714268990, pid, 0, 0, 0, 0, 0, 0, 0 })
        end)
    menu.action(vehicle_stuff, "Destroy Personal Vehicle", { "destroypersonal" }, "Destroys the personal vehicle of the player.", function()
        util.trigger_script_event(1 << pid, { -2126830022, pid, pid })
        util.trigger_script_event(1 << pid, { -714268990, pid, 0, 0, 0, 0, 0, 0, 0 })
    end)
    menu.action(vehicle_stuff, "Lester Raid", { "lesterraid" }, "Raids the player's vehicle with a party of Lesters.", function()
        util.trigger_script_event(1 << pid, { -714268990, pid, 0, 0, 0, 0, 0, 0, 0 })
        util.yield(2500)
        if not STREAMING.IS_MODEL_VALID(2013139108) then
            util.yield()
        end
        STREAMING.REQUEST_MODEL(2013139108)
        local lester_driver = entities.create_ped(28, 2013139108, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)), math.random(0, 270))
        PED.SET_PED_INTO_VEHICLE(lester_driver, PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true), -1)
        for _ = 0, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)) - 1 do
            local lester_passenger = entities.create_ped(28, 2013139108, ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)), math.random(0, 270))
            PED.SET_PED_INTO_VEHICLE(lester_passenger, PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true), -2)
        end
        PED.SET_PED_COMBAT_ATTRIBUTES(lester_driver, 46, true)
        PED.SET_PED_CAN_BE_DRAGGED_OUT(lester_driver, false)
        ENTITY.SET_ENTITY_INVINCIBLE(lester_driver, true)
        TASK.TASK_VEHICLE_DRIVE_WANDER(lester_driver, PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true), 100.00, 524820)
    end)
    menu.toggle(vehicle_stuff, "No Grip", { "nogrip" }, "Removes all traction from the player's vehicle.",
        function(enabled)
            request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false))
            if enabled then
                if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)) then
                    VEHICLE.SET_VEHICLE_REDUCE_GRIP(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false), true)
                else
                    util.toast("Could not get control of vehicle.")
                end
            else
                VEHICLE.SET_VEHICLE_REDUCE_GRIP(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false), false)
            end
        end)
    menu.toggle(vehicle_stuff, "Freeze Vehicle", { "vehiclefreeze" }, "Stops the player's vehicle in place.", function(enabled)
            request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false))
            if enabled then
                if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)) then
                    ENTITY.FREEZE_ENTITY_POSITION(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false), true)
                else
                    util.toast("Could not get control of vehicle.")
                end
            else
                ENTITY.FREEZE_ENTITY_POSITION(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false), false)
            end
        end)
    menu.toggle_loop(hvh_stuff, "Remove Godmode", { "removegodmode" }, "Removes the player's godmode. This will only work on bad menus.", function()
        util.trigger_script_event(1 << pid, { -1388926377, pid, -1762807505, math.random(0, 9000) })
    end)
    menu.toggle_loop(hvh_stuff, "Annoying Loop", { "annoyinggmloop" }, "Yet another annoying loop, only this one is for godmode players.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 0.5, pos.x, pos.y, pos.z, 0, true, 2939590305, pid, false, true, 1.0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 0.5, pos.x, pos.y, pos.z, 0, true, 2138347493, pid, false, true, 300.0)
    end)
end

players.on_join(player)
players.dispatch_on_join()
util.keep_running()
