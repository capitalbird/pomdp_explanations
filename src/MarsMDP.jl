using Pkg
Pkg.add("POMDPs")

using POMDPs

struct MarsMDP <: MDP{Tuple{Int, Int}, Int} #MDP{state, action}
end

function states(mdp::MarsMDP)
    return[on_earth, on_mars_loc1, on_mars_loc2, on_mars_loc3, on_mars_loc4, on_mars_loc5, on_mars_loc6]
end

function actions(mdp::MarsMDP)
    return[to_mars, unload_rover, move, take_air_sample, take_water_sample, load_rover, to_earth]
end

function transition(mdp::MarsMDP, s, a)
    if s == on_earth && a == to_mars
        return on_mars_loc1
    elseif s == on_mars_loc1 && a == move
        return on_mars_loc2
    elseif s == on_mars_loc2 && a == move
        return on_mars_loc3
    elseif s == on_mars_loc3 && a == move
        return on_mars_loc4
    elseif s == on_mars_loc4 && a == move
        return on_mars_loc5
    elseif s == on_mars_loc5 && a == move
        return on_mars_loc6
    elseif s == on_mars_loc6 && a == move
        return on_mars_loc5
    elseif s == on_mars_loc5 && a == move
        return on_mars_loc4
    elseif s == on_mars_loc4 && a == move
        return on_mars_loc3
    elseif s == on_mars_loc3 && a == move
        return on_mars_loc2
    elseif s == on_mars_loc2 && a == move
        return on_mars_loc1
end

function reward(mdp::MarsMDP, s::Tuple{Int, Int}, a::Tuple{Int, Int}, sp::Tuple{Int, Int})
    # return s == mdp.goal ? 1.0 : 0.0
end

function discount(mdp::MarsMDP)
    # return mdp.discount_factor
end

mdp = MarsMDP()

end