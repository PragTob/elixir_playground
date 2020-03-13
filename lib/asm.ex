# Inspired by and making it on a statement/function level
# https://gist.github.com/sasa1977/73274c2be733b5321ace
defmodule ASM do
  def for(code) do
    code = """
    defmodule Test do
      def test do
        #{code}
      end
    end
    """

    [{_, beam}] = Code.compile_string(code)
    {:ok, {_, [{:abstract_code, {_, abstract_code}}]}} = :beam_lib.chunks(beam, [:abstract_code])
    {:ok, _module, asm} = :compile.forms(abstract_code, [:to_asm])
    IO.inspect(asm)
  end
end
