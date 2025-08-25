# load my main code -
include(joinpath("..", "Include.jl"))

# load and run my test code -
@testset verbose=true "Hello World" begin
    @test printgreeting() == "Hello World!";
    @test printgreeting() != "Not Hello World!"
end