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

Benchee.run(
  %{
    "just Jason" => fn input -> Jason.encode_to_iodata!(input) end,
    "logger_json encode" => fn input ->
      %{message: LoggerJSON.Formatter.RedactorEncoder.encode(input, redactors)}
    end,
    "whole logger format" => fn input ->
      LoggerJSON.Formatters.Basic.format(%{level: :info, meta: %{}, msg: {:report, input}}, [])
    end
  },
  inputs: inputs,
  formatters: [{Benchee.Formatters.Console, extended_statistics: true}]
)

# Operating System: Linux
# CPU Information: AMD Ryzen 9 5900X 12-Core Processor
# Number of Available Cores: 24
# Available memory: 31.26 GB
# Elixir 1.17.3
# Erlang 27.1
# JIT enabled: true

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# reduction time: 0 ns
# parallel: 1
# inputs: just a msg, some map, bigger_map
# Estimated total run time: 1 min 3 s

# Benchmarking just Jason with input just a msg ...
# Benchmarking just Jason with input some map ...
# Benchmarking just Jason with input bigger_map ...
# Benchmarking logger_json encode with input just a msg ...
# Benchmarking logger_json encode with input some map ...
# Benchmarking logger_json encode with input bigger_map ...
# Benchmarking whole logger format with input just a msg ...
# Benchmarking whole logger format with input some map ...
# Benchmarking whole logger format with input bigger_map ...
# Calculating statistics...
# Formatting results...

# ##### With input just a msg #####
# Name                          ips        average  deviation         median         99th %
# just Jason                 3.01 M      332.23 ns  ±9650.30%         270 ns         550 ns
# logger_json encode         1.33 M      751.78 ns  ±5727.22%         640 ns        1230 ns
# whole logger format        0.46 M     2170.83 ns  ±1068.01%        2030 ns        3560 ns

# Comparison:
# just Jason                 3.01 M
# logger_json encode         1.33 M - 2.26x slower +419.55 ns
# whole logger format        0.46 M - 6.53x slower +1838.59 ns

# Extended statistics:

# Name                        minimum        maximum    sample size                     mode
# just Jason                   240 ns    54223721 ns         9.18 M                   260 ns
# logger_json encode           560 ns    66101593 ns         5.21 M                   640 ns
# whole logger format         1830 ns    23157131 ns         2.08 M                  1990 ns

# ##### With input some map #####
# Name                          ips        average  deviation         median         99th %
# logger_json encode       732.91 K        1.36 μs  ±2547.28%        1.23 μs        1.89 μs
# just Jason               303.60 K        3.29 μs  ±1112.07%        2.42 μs        5.59 μs
# whole logger format      185.90 K        5.38 μs   ±451.79%        4.56 μs       10.34 μs

# Comparison:
# logger_json encode       732.91 K
# just Jason               303.60 K - 2.41x slower +1.93 μs
# whole logger format      185.90 K - 3.94x slower +4.01 μs

# Extended statistics:

# Name                        minimum        maximum    sample size                     mode
# logger_json encode          1.11 μs    31718.86 μs         3.10 M                  1.23 μs
# just Jason                  1.56 μs    20270.33 μs         1.39 M                  2.38 μs
# whole logger format         3.79 μs    14038.87 μs       887.15 K                  4.22 μs

# ##### With input bigger_map #####
# Name                          ips        average  deviation         median         99th %
# just Jason               255.76 K        3.91 μs   ±736.51%        3.64 μs        7.09 μs
# logger_json encode        95.88 K       10.43 μs   ±111.97%       10.14 μs       21.18 μs
# whole logger format       66.06 K       15.14 μs    ±47.10%       14.67 μs       26.58 μs

# Comparison:
# just Jason               255.76 K
# logger_json encode        95.88 K - 2.67x slower +6.52 μs
# whole logger format       66.06 K - 3.87x slower +11.23 μs

# Extended statistics:

# Name                        minimum        maximum    sample size                     mode
# just Jason                  3.02 μs    19332.05 μs         1.21 M                  3.59 μs
# logger_json encode          8.88 μs     7043.16 μs       467.91 K                 10.15 μs
# whole logger format        13.28 μs     3032.60 μs       324.48 K                 14.61 μs
