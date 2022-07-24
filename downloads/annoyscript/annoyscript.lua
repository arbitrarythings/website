-- 0.2
util.toast("Welcome to Endow's Annoyscript. You're now a cool kid")
util.require_natives(1640181023)

local function request_control(entity)
    local i = 0
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and i < 100000 do
        util.yield()
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        i = i + 1
    end
end

local function player(pid)
    local detections = { "Being too awesome", "Annoyscript developer", "Rockstar CEO (leave session immediately)" }
    if players.get_rockstar_id(pid) == 211749254 then -- thanks for the idea, Prism
        util.toast(players.get_name(pid) .. " triggered a detection: " .. detections[math.random(#detections)])
    end
    menu.divider(menu.player_root(pid), "Endow's Annoyscript")
    local annoying_stuff = menu.list(menu.player_root(pid), "Annoying Stuff", {}, "")
    local vehicle_stuff = menu.list(menu.player_root(pid), "Vehicle Stuff", {}, "")
    local hvh_stuff = menu.list(menu.player_root(pid), "HVH Stuff", {}, "")
    menu.toggle_loop(annoying_stuff, "Message Spam", { "txtspam" },
        "Spams the player with troll texts and sound effects.", function()
        util.trigger_script_event(1 << pid, { -1702264142, pid, 5423258964353897800, 844318034 })
    end)
    menu.toggle_loop(annoying_stuff, "Fake Insurance Payments", { "fakeinsurance" },
        "Spams the player with fake insurance payment notifications.", function()
        util.trigger_script_event(1 << pid, { 0x2FCF970F, pid, math.random(0, 2147483647) })
    end)
    menu.toggle_loop(annoying_stuff, "Harmless Explosion Loop", { "harmlessbombloop" },
        "Loops a harmless explosion near the player.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 26, 0, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 36, 0, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 38, 0, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 32, 0, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 59, 0, true, false, 1, false)
    end)
    menu.toggle_loop(annoying_stuff, "Annoying Loop", { "annoyingloop" },
        "Loops a bunch of annoying stuff near the player.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 38, 0, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 70, 0, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 65, 0, true, false, 1, false)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 2, 63, 0, true, false, 1, false)
        FIRE.STOP_FIRE_IN_RANGE(pos.x, pos.y, pos.z, 10)
    end)
    menu.toggle_loop(annoying_stuff, "Ear Rape v1", { "earrape1" },
        "Ear rape the player, only works on legit players as far as I know.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        for _ = 0, 100 do
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "Horn", pos.x, pos.y, pos.z, "DLC_Apt_Yacht_Ambient_Soundset", true, 1)
            AUDIO.PLAY_SOUND_FROM_COORD(-1, "LOSER", pos.x, pos.y, pos.z, "HUD_AWARDS", true, 1)
        end
        util.yield(1000)
    end)
    menu.toggle_loop(annoying_stuff, "Ear Rape v2", { "earrape2" }, "Ear rape the player using another fun sound.",
        function()
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
            for _ = 0, 100 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", pos.x, pos.y, pos.z, "WastedSounds", true, 1)
            end
        end)
    menu.action(annoying_stuff, "Stop All Sounds", { "stopsounds" },
        "Stops all the sounds (to counter ear-rape), pretty self explanatory.", function()
        for i = -1, 100 do
            AUDIO.STOP_SOUND(i)
            AUDIO.RELEASE_SOUND_ID(i)
        end
    end)
    menu.action(annoying_stuff, "Box Player", { "boxplayer" }, "Boxes the player up for easy shipment to China.",
        function()
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
            if not STREAMING.IS_MODEL_VALID(1765283457) then
                util.yield()
            end
            STREAMING.REQUEST_MODEL(1765283457)
            OBJECT.CREATE_OBJECT_NO_OFFSET(1765283457, pos.x, pos.y, pos.z - 1, true, false, false)
        end)
    menu.action(annoying_stuff, "Mime Player", { "mimeplayer" }, "Same as box player, only this one is invisible.",
        function()
            local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
            if not STREAMING.IS_MODEL_VALID(1765283457) then
                util.yield()
            end
            STREAMING.REQUEST_MODEL(1765283457)
            local box = OBJECT.CREATE_OBJECT_NO_OFFSET(1765283457, pos.x, pos.y, pos.z - 1, true, false, false)
            ENTITY.SET_ENTITY_VISIBLE(box, false)
        end)
    menu.action(annoying_stuff, "Send To Island", { "sendisland" }, "Ships the player off to Cayo Perico.", function()
        util.trigger_script_event(1 << pid, { 1463943751, pid, 0, 0, 4, 1, 0 })
    end)
    menu.action(annoying_stuff, "Send Chris Formage", { "sendchris" },
        "Sends Chris Formage to blast the player into outer space.", function()
        local ped = util.joaat("IG_CHRISFORMAGE")
        if not STREAMING.IS_MODEL_VALID(ped) then
            util.yield()
        end
        STREAMING.REQUEST_MODEL(ped)
        for _ = 1, 10 do
            local attacker = entities.create_ped(28, ped,
                ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)), math.random(0, 270))
            TASK.TASK_COMBAT_PED(attacker, PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), 0, 16)
            PED.SET_PED_AS_COP(attacker, true)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, 2939590305, 0, false, true)
        end
    end)
    menu.action(vehicle_stuff, "Send Vehicle Flying", { "launchv" }, "Sends the player's vehicle flying.", function()
        request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false))
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)) then
            for _ = 0, 10 do
                ENTITY.APPLY_FORCE_TO_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false), 2
                    , 0, 0, 10000, 0, 0, 0, 0, true, false, true, false, true)
            end
        else
            util.toast("Could not get control of vehicle.")
        end
    end)
    menu.action(vehicle_stuff, "Make Them Crash", { "crashcar" }, "Makes the player crash their car.", function()
        request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false))
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false)) then
            for _ = 0, 10 do
                ENTITY.APPLY_FORCE_TO_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false), 2
                    , 1000, 0, 0, 0, 0, 0, 0, true, false, true, false, true)
            end
        else
            util.toast("Could not get control of vehicle.")
        end
    end)
    menu.action(vehicle_stuff, "Kill Engine", { "killengine" }, "Kills the engine of the player's vehicle.",
        function()
            request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false))
            if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid),
                false)) then
                VEHICLE.SET_VEHICLE_ENGINE_HEALTH(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid),
                    false), -4000.0)
            else
                util.toast("Could not get control of vehicle.")
            end
        end)
    menu.toggle_loop(vehicle_stuff, "Freeze Vehicle", { "vehiclefreeze" }, "Stops the player's vehicle in place."
        ,
        function(enabled)
            request_control(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), false))
            if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid),
                false)) then
                if enabled then
                    VEHICLE._SET_VEHICLE_MAX_SPEED(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid),
                        false)
                        , 0)
                else
                    VEHICLE._SET_VEHICLE_MAX_SPEED(PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid),
                        false)
                        , -1)
                end
            end
        end)
    menu.toggle_loop(hvh_stuff, "Remove Godmode", { "removegodmode" },
        "Removes the player's godmode. This will only work on bad menus.", function()
        util.trigger_script_event(1 << pid, { 801199324, pid, 869796886, math.random(0, 9999) })
    end)
    menu.toggle_loop(hvh_stuff, "Annoying Loop", { "annoyinggmloop" },
        "Yet another annoying loop, only this one is for godmode players.", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 0.5, pos.x, pos.y, pos.z, 0, true, 2939590305, pid
            , false, true, 1.0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 0.5, pos.x, pos.y, pos.z, 0, true, 2138347493, pid
            , false, true, 300.0)
    end)
end

players.on_join(player)
players.dispatch_on_join()
util.keep_running()
