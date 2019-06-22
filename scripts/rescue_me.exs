defmodule RescueMe do
  def run do
    spawn_link fn ->
      try do
        raise "lol"
      rescue
        e ->
          IO.puts "error"
          reraise e, System.stacktrace
      end
    end
  end
end

try do
  RescueMe.run
rescue
  _ -> IO.puts "I rescued you"
end
