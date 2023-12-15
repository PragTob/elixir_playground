# From a conversation on #benchee slack with starbelly
# results between erlperf and benchee were different so do something very simple to minimize a chance for bugs:

defmodule MyTime do
  def collect(function) do
    start = :erlang.monotonic_time()
    function.()
    finish = :erlang.monotonic_time()

    duration_nano_seconds = :erlang.convert_time_unit(finish - start, :native, :nanosecond)
    duration_nano_seconds
  end
end

payload = %{payload: :rand.bytes(1024)}

warmup_iterations = 1_000
measure_iterations = 10_000

binary_times =
  Task.async(fn ->
    # warmup
    Enum.map(1..warmup_iterations, fn _ ->
      MyTime.collect(fn -> :erlang.term_to_binary(payload) end)
    end)

    Enum.map(1..measure_iterations, fn _ ->
      MyTime.collect(fn -> :erlang.term_to_binary(payload) end)
    end)
  end)
  |> Task.await()

vec_times =
  Task.async(fn ->
    Enum.map(1..warmup_iterations, fn _ ->
      MyTime.collect(fn -> :erlang.term_to_iovec(payload) end)
    end)

    Enum.map(1..measure_iterations, fn _ ->
      MyTime.collect(fn -> :erlang.term_to_iovec(payload) end)
    end)
  end)
  |> Task.await()

IO.inspect(binary_times, label: "Binary times:")
IO.inspect(vec_times, label: "vex times:")

IO.inspect(Statistex.statistics(binary_times), label: "binary statistics:")
IO.inspect(Statistex.statistics(vec_times), label: "vec statistics:")
