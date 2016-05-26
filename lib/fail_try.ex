defmodule MyFail do

  alias A.B

  def method do
    B.nonexistebt
  end

end
