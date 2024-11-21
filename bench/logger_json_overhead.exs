# now = DateTime.utc_now()

inputs = [
  {"just a msg", %{message: "This is just some elaborate message"}},
  {"some map",
   %{
     message: "some other weirdo message",
     time: DateTime.utc_now(),
     http_meta: %{
       status: 500,
       method: "GET",
       headers: [["what", "eva"], ["some-more", "stuff"]]
     }
   }},
  {"bigger_map",
   %{
     "users" => %{
       "user_1" => %{
         "name" => "Alice",
         "age" => 30,
         "preferences" => %{
           "theme" => "dark",
           "language" => "English",
           "notifications" => %{
             "email" => true,
             "sms" => false,
             "push" => true
           }
         },
         "tags" => ["developer", "team_lead"]
       },
       "user_2" => %{
         "name" => "Bob",
         "age" => 25,
         "preferences" => %{
           "theme" => "light",
           "language" => "French",
           "notifications" => %{
             "email" => true,
             "sms" => true,
             "push" => false
           }
         },
         "tags" => ["designer", "remote"]
       }
     },
     "settings" => %{
       "global" => %{
         "timezone" => "UTC",
         "currency" => :usd,
         "support_contact" => "support@example.com"
       },
       "regional" => %{
         "US" => %{
           "timezone" => "America/New_York",
           "currency" => :usd
         },
         "EU" => %{
           "timezone" => "Europe/Berlin",
           "currency" => "EUR"
         }
       }
     },
     "analytics" => %{
       "page_views" => %{
         "home" => 1200,
         "about" => 450,
         "contact" => 300
       },
       "user_sessions" => %{
         "total" => 2000,
         "active" => 150
       }
     }
   }}
]

redactors = []
{_, default_formatter_config} = Logger.Formatter.new(colors: [enabled?: false])

Benchee.run(
  %{
    "just Jason" => fn input -> Jason.encode_to_iodata!(input) end,
    "logger_json encode" => fn input ->
      %{message: LoggerJSON.Formatter.RedactorEncoder.encode(input, redactors)}
    end,
    "whole logger format" => fn input ->
      LoggerJSON.Formatters.Basic.format(%{level: :info, meta: %{}, msg: {:report, input}}, [])
    end,
    # odd that those 2 end up being the slowest - what additional work are they doing?
    "default formatter with report data (sanity check)" => fn input ->
      Logger.Formatter.format(
        %{level: :info, meta: %{}, msg: {:report, input}},
        default_formatter_config
      )
    end,
    "default formatter with pre-formatted report data  as string (sanity check 2)" =>
      {fn input ->
         Logger.Formatter.format(
           %{level: :info, meta: %{}, msg: {:string, input}},
           default_formatter_config
         )
       end, before_scenario: &inspect/1}
  },
  warmup: 0.1,
  time: 1,
  inputs: inputs
)

# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.26 GB
# Elixir 1.17.3
# Erlang 27.1
# JIT enabled: true

# Benchmark suite executing with the following configuration:
# warmup: 100 ms
# time: 1 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: just a msg, some map, bigger_map
# Estimated total run time: 16 s 500 ms

# ##### With input just a msg #####
# Name                                                                                   ips        average  deviation         median         99th %
# just Jason                                                                       2830.72 K        0.35 μs ±10003.68%        0.26 μs        0.47 μs
# logger_json encode                                                               1356.70 K        0.74 μs  ±3335.62%        0.62 μs        1.25 μs
# whole logger format                                                               471.89 K        2.12 μs   ±278.98%        2.01 μs        3.74 μs
# default formatter with pre-formatted report data  as string (sanity check 2)      421.85 K        2.37 μs   ±510.49%        2.26 μs        3.54 μs
# default formatter with report data (sanity check)                                 177.04 K        5.65 μs   ±109.63%        5.44 μs        8.66 μs

# Comparison:
# just Jason                                                                       2830.72 K
# logger_json encode                                                               1356.70 K - 2.09x slower +0.38 μs
# whole logger format                                                               471.89 K - 6.00x slower +1.77 μs
# default formatter with pre-formatted report data  as string (sanity check 2)      421.85 K - 6.71x slower +2.02 μs
# default formatter with report data (sanity check)                                 177.04 K - 15.99x slower +5.30 μs

# ##### With input some map #####
# Name                                                                                   ips        average  deviation         median         99th %
# logger_json encode                                                                783.64 K        1.28 μs   ±676.40%        1.18 μs        2.02 μs
# default formatter with pre-formatted report data  as string (sanity check 2)      425.95 K        2.35 μs   ±226.76%        2.27 μs        3.39 μs
# just Jason                                                                        391.49 K        2.55 μs   ±652.46%        1.74 μs        6.87 μs
# whole logger format                                                               209.54 K        4.77 μs   ±170.75%        4.29 μs       14.87 μs
# default formatter with report data (sanity check)                                  75.60 K       13.23 μs    ±27.32%       12.50 μs       21.52 μs

# Comparison:
# logger_json encode                                                                783.64 K
# default formatter with pre-formatted report data  as string (sanity check 2)      425.95 K - 1.84x slower +1.07 μs
# just Jason                                                                        391.49 K - 2.00x slower +1.28 μs
# whole logger format                                                               209.54 K - 3.74x slower +3.50 μs
# default formatter with report data (sanity check)                                  75.60 K - 10.37x slower +11.95 μs

# ##### With input bigger_map #####
# Name                                                                                   ips        average  deviation         median         99th %
# default formatter with pre-formatted report data  as string (sanity check 2)      413.12 K        2.42 μs   ±243.13%        2.27 μs        5.21 μs
# just Jason                                                                        267.60 K        3.74 μs    ±94.93%        3.54 μs        6.48 μs
# logger_json encode                                                                 97.94 K       10.21 μs    ±31.68%        9.89 μs       16.91 μs
# whole logger format                                                                65.13 K       15.35 μs    ±25.26%       14.98 μs       19.64 μs
# default formatter with report data (sanity check)                                  20.29 K       49.29 μs    ±13.24%       48.20 μs       69.95 μs

# Comparison:
# default formatter with pre-formatted report data  as string (sanity check 2)      413.12 K
# just Jason                                                                        267.60 K - 1.54x slower +1.32 μs
# logger_json encode                                                                 97.94 K - 4.22x slower +7.79 μs
# whole logger format                                                                65.13 K - 6.34x slower +12.93 μs
# default formatter with report data (sanity check)                                  20.29 K - 20.36x slower +46.87 μs
