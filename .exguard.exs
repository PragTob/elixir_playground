use ExGuard.Config

project_files = ~r{\.(erl|ex|exs|eex|xrl|yrl)\z}i
deps = ~r{deps}

guard("compile and warn", run_on_start: true)
|> command("MIX_ENV=test mix compile --warnings-as-errors")
|> watch(project_files)
|> ignore(deps)
|> notification(:auto)

guard("mix format", run_on_start: true)
|> command("mix format --check-formatted")
|> watch(project_files)
|> ignore(deps)
|> notification(:auto)

guard("test", run_on_start: true)
|> command("mix test --color --stale")
|> watch(project_files)
|> ignore(deps)
|> notification(:auto)
