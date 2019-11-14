ExUnit.start()

Application.ensure_all_started(:mox)

Mox.defmock(BarkMock, for: Bark)
Mox.stub_with(BarkMock, BarkImpl)

# Application.put_env(:mox_issue, bark: BarkMock)

IO.puts("executed")
