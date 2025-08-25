# setup paths -
const _ROOT = pwd()
const _PATH_TO_SRC = joinpath(_ROOT, "src")
const _PATH_TO_TEST = joinpath(_ROOT, "test")

# external packages -
using Test

# my codes -
include(joinpath(_PATH_TO_SRC, "HelloWorld.jl"))