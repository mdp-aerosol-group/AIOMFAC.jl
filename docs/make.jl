push!(LOAD_PATH, "../src/")

using Documenter

makedocs(
		 sitename="AIOMFAC.jl",
		 authors = "Markus Petters",
		 pages = Any[
					 "Home" => "index.md",
					]
		)
