###############################################################################
#
# Capacitance for plants
#
###############################################################################
"""
    abstract type AbstractCapacity{FT}

Hierachy of AbstractCapacity
"""
abstract type AbstractCapacity{FT<:AbstractFloat} end




"""
    mutable struct PVCurveLinear{FT}

Struct that contains information for linear PV curve

# Fields
$(DocStringExtensions.FIELDS)
"""
Base.@kwdef mutable struct PVCurveLinear{FT} <: AbstractCapacity{FT}
    "Slope of the linear PV curve (relative to maximum) `[MPa⁻¹]`"
    slope   ::FT = 0.2
    "Conductance for refilling (relative to maximum) `[MPa⁻¹ s⁻¹]`"
    k_refill::FT = 0.0001
end








###############################################################################
#
# Vulnerability curves for xylem
#
###############################################################################
"""
    abstract type AbstractXylemVC{FT}

Hierachy of AbstractXylemVC
- [`WeibullSingle`](@ref)
- [`WeibullDual`](@ref)
"""
abstract type AbstractXylemVC{FT<:AbstractFloat} end




"""
    mutable struct WeibullDual{FT}

Struct that contains dual Weibull function parameters.

# Fields
$(DocStringExtensions.FIELDS)
"""
Base.@kwdef mutable struct WeibullDual{FT} <: AbstractXylemVC{FT}
    "B of first part `[MPa]`"
    b1::FT = 1
    "C of first part"
    c1::FT = 5
    "F of first part"
    f1::FT = 0.5
    "B of second part `[MPa]`"
    b2::FT = 2
    "C of second part"
    c2::FT = 5
    "F of second part"
    f2::FT = 1 - f1
end




"""
    mutable struct WeibullSingle{FT}

Struct that contains single Weibull function parameters.

# Fields
$(DocStringExtensions.FIELDS)
"""
Base.@kwdef mutable struct WeibullSingle{FT} <: AbstractXylemVC{FT}
    "B of first part `[MPa]`"
    b::FT = 2
    "C of first part"
    c::FT = 5
end








###############################################################################
#
# Vulnerability curves for soil
#
###############################################################################
"""
    abstract type AbstractSoilVC{FT}

Hierachy of AbstractSoilVC:
- [`BrooksCorey`](@ref)
- [`VanGenuchten`](@ref)
"""
abstract type AbstractSoilVC{FT<:AbstractFloat} end




"""
    mutable struct BrooksCorey{FT<:AbstractFloat}

Brooks Corey soil parameters

# Fields
$(DocStringExtensions.FIELDS)
"""
Base.@kwdef mutable struct BrooksCorey{FT} <: AbstractSoilVC{FT}
    "Soil type"
    stype::String = "TBD"
    "Soil b"
    b ::FT = 8.52
    "ϕ at saturation `[MPa]`"
    ϕs::FT = 0.63 * ρg_MPa(FT)
    "Soil water content (Θ) at saturation"
    Θs::FT = 0.476
    "Residual soil water content"
    Θr::FT = 0.1
end




"""
    mutable struct VanGenuchten{FT<:AbstractFloat}

Van Gunechten soil parameters

# Fields
$(DocStringExtensions.FIELDS)
"""
Base.@kwdef mutable struct VanGenuchten{FT} <: AbstractSoilVC{FT}
    "Soil type"
    stype::String = "Sandy Clay Loam"
    "Soil α is related to the inverse of the air entry suction, α > 0"
    α ::FT = 602.0419
    "Soil n is Measure of the pore-size distribution"
    n ::FT = 1.48
    "Soil m = 1 - 1/n"
    m ::FT = 1 - 1/n
    "Soil water content (Θ) at saturation"
    Θs::FT = 0.39
    "Residual soil water content"
    Θr::FT = 0.1
end
