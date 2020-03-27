defmodule TimeularReportGenerator do
  @client_activity_name "Client Matestack OSS"
  def create(json_string) do
    times = sorted_list_of_times(json_string)

    total_time = total_time(times)

    daily_reports = daily_reports(times)

    report = daily_reports <> "\n\n" <> total_time_report(total_time)

    IO.puts(report)
  end

  defp sorted_list_of_times(json_string) do
    json_string
    |> Jason.decode!()
    |> Map.fetch!("timeEntries")
    |> Enum.filter(fn entry_data ->
      get_in(entry_data, ["activity", "name"]) == @client_activity_name
    end)
    |> Enum.map(fn entry_data ->
      duration = Map.fetch!(entry_data, "duration")

      {
        duration |> Map.fetch!("startedAt") |> parse_time,
        duration |> Map.fetch!("stoppedAt") |> parse_time
      }
    end)
    |> Enum.sort_by(fn {start_time, _} ->
      NaiveDateTime.to_erl(start_time)
    end)
  end

  defp parse_time(time_stamp) do
    time_stamp
    |> NaiveDateTime.from_iso8601!()
    |> Timex.Timezone.convert("Europe/Berlin")
  end

  defp total_time(times) do
    times
    |> Enum.map(fn {start, finish} -> NaiveDateTime.diff(finish, start) end)
    |> Enum.sum()
  end

  defp daily_reports(times) do
    times
    |> Enum.group_by(fn {start_time, _} -> NaiveDateTime.to_date(start_time) end)
    |> Enum.sort_by(fn {day, _slices} -> Date.to_erl(day) end)
    |> Enum.map(&format_day/1)
    |> Enum.join("\n")
  end

  defp format_day({day, slices}) do
    """
    ### #{day} (#{hour_display(total_time(slices))} h)
    #{format_slices(slices)}
    """
  end

  defp hour_display(time) do
    minutes = div(time, 60)
    hours = div(minutes, 60)

    leftover_minutes = rem(minutes, 60)
    leftover_seconds = rem(time, 60)

    "#{hours}:#{two_numbers(leftover_minutes)}:#{two_numbers(leftover_seconds)}"
  end

  defp two_numbers(number) when number < 10 do
    "0#{number}"
  end

  defp two_numbers(number) do
    number
  end

  defp format_slices(slices) do
    slices
    |> Enum.map(fn {start, finish} ->
      "#{time_of(start)} - #{time_of(finish)}"
    end)
    |> Enum.join("\n")
  end

  defp time_of(date_time) do
    date_time
    |> NaiveDateTime.truncate(:second)
    |> NaiveDateTime.to_time()
  end

  defp total_time_report(total_time) do
    total_hours = total_time / 3600.0

    """
    ---------------------------------------------------------------
    Total Time: #{hour_display(total_time)} h (rounded up: #{round_up(total_hours)} h)
    """
  end

  defp round_up(float) do
    Float.ceil(float)
  end
end
