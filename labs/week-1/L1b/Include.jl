# setup paths -
const _ROOT = pwd()
const _PATH_TO_SRC = joinpath(_ROOT, "src")
const _PATH_TO_TEST = joinpath(_ROOT, "test")

# check:
const _DID_INCLUDE_GET_CALLED = true; # only true if this file was called

# external packages -
using Test
using UnicodePlots
using Statistics

# my codes -
include(joinpath(_PATH_TO_SRC, "HelloWorld.jl"))