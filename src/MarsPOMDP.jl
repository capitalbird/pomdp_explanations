# import Pkg;
# using Pkg
# Pkg.add("POMDPs")
# Pkg.add("QuickPOMDP")
# Pkg.add("POMDPTools")
# Pkg.add("POMDPToolbox")

# using POMDPs

using POMDPs, QuickPOMDPs, POMDPTools, QMDP

m = QuickPOMDP(
    states = ["on_earth", "on_mars_loc1", "on_mars_loc2", "on_mars_loc3", "on_mars_loc4", "on_mars_loc5", "on_mars_loc6"],
    actions = ["to_mars", "unload_rover", "move", "take_air_sample", "take_water_sample", "load_rover", "to_earth"],
    observations = [],
    initialstate = "on_earth",
    discount = 0,

    transition = function (s, a)
        if s == "on_earth" && a == "to_mars"
            return "on_mars_loc1"
        elseif s == "on_mars_loc1" && a == "move"
            return "on_mars_loc2"
        elseif s == "on_mars_loc2" && a == "move"
            return "on_mars_loc3"
        elseif s == "on_mars_loc3" && a == "move"
            return "on_mars_loc4"
        elseif s == "on_mars_loc4" && a == "move"
            return "on_mars_loc5"
        elseif s == "on_mars_loc5" && a == "move"
            return "on_mars_loc6"
        elseif s == "on_mars_loc6" && a == "move"
            return "on_mars_loc5"
        elseif s == "on_mars_loc5" && a == "move"
            return "on_mars_loc4"
        elseif s == "on_mars_loc4" && a == "move"
            return "on_mars_loc3"
        elseif s == "on_mars_loc3" && a == "move"
            return "on_mars_loc2"
        elseif s == "on_mars_loc2" && a == "move"
            return "on_mars_loc1"
        end
    end,

    observation = function (s, a, sp)
        return s
    end,

    reward = function (s, a)
        if a == move
            return -5
        elseif a == take_air_sample
            return -1
        elseif a == take_water_sample
            return -1
        # elseif s == water_found
        #     return 100
        # elseif s = have_run_tests #to determine if planet is hospitable
        #     return 100
        else # the tiger was escaped
            return 0
        end
    end
)

solver = QMDPSolver()
policy = solve(solver, m)

rsum = 0.0
for (s,b,a,o,r) in stepthrough(m, policy, "s,b,a,o,r", max_steps=10)
    println("s: $s, b: $([s=>pdf(b,s) for s in states(m)]), a: $a, o: $o")
    global rsum += r
end
println("Undiscounted reward was $rsum.")