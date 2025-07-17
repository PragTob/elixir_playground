# Different ways of getting the status, for science and progress
# So far the benchmark shows no meaningful difference, which makes sense
# The function is too fast on a macbook to show meaningful values

defmodule Status do
  def status(:ok), do: :ok
  def status(:already_exists), do: :already_exists
  def status(:failed_precondition), do: :failed_precondition
  def status(:invalid_argument), do: :invalid_argument
  def status(:internal), do: :internal
  def status(:permission_denied), do: :permission_denied
  def status(:not_found), do: :not_found
  def status(:unauthenticated), do: :unauthenticated
  def status(:unknown), do: :unknown
  def status(unknown), do: raise("Unimplemented status #{inspect(unknown)} in RPC bridge")

  @map %{
    :ok => :ok,
    :already_exists => :already_exists,
    :failed_precondition => :failed_precondition,
    :invalid_argument => :invalid_argument,
    :internal => :internal,
    :permission_denied => :permission_denied,
    :not_found => :not_found,
    :unauthenticated => :unauthenticated,
    :unknown => :unknown
  }
  def status_map(status), do: Map.fetch!(@map, status)

  @valid_statuses Map.keys(@map)

  def status_list(status) when status in @valid_statuses, do: status
  def status_list(status), do: raise("Unimplemented status #{inspect(status)} in RPC bridge")

  def random_status, do: Enum.random(@valid_statuses)
end

Benchee.run(
  %{
    "pattern match" => &Status.status/1,
    "map" => &Status.status_map/1,
    "list" => &Status.status_list/1
  },
  before_each: fn _ -> Status.random_status() end,
  formatters: [{Benchee.Formatters.Console, extended_statistics: true}],
  max_sample_size: 5_000_000
)

# tobi@qiqi:~/github/elixir_playground(main)$ mix run bench/map_vs_pattern.exs
# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.26 GB
# Elixir 1.18.3
# Erlang 27.3.2
# JIT enabled: true

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 21 s

# Benchmarking list ...
# Benchmarking map ...
# Benchmarking pattern match ...
# Calculating statistics...
# Formatting results...

# Name                    ips        average  deviation         median         99th %
# pattern match       38.26 M       26.14 ns    ±95.29%          30 ns          40 ns
# list                35.80 M       27.93 ns   ±121.10%          30 ns          60 ns
# map                 34.00 M       29.41 ns    ±92.40%          30 ns          40 ns

# Comparison:
# pattern match       38.26 M
# list                35.80 M - 1.07x slower +1.79 ns
# map                 34.00 M - 1.13x slower +3.28 ns

# Extended statistics:

# Name                  minimum        maximum    sample size                     mode
# pattern match           20 ns       13181 ns            5 M                    30 ns
# list                    20 ns       40802 ns            5 M                    30 ns
# map                     20 ns       14461 ns            5 M                    30
