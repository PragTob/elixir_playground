defmodule RASM do
  # see perf argument for instructions, it's about the same
  @initial_registers [nil, nil, nil]

  @result_register "C"
  @register_to_index %{
    "A" => 0,
    "B" => 1,
    @result_register => 2
  }
  @registers Map.keys(@register_to_index)

  def run_program(program) do
    instruction_index = 0

    # note: keeps instructions in a (linked) list, which isn't great for random access
    # so a map might be considered, but since map internally works as a list
    # until ~32 elements there should be no performance difference
    program
    |> split_instructions()
    |> evaluate(@initial_registers, instruction_index)
  end

  defp split_instructions(program) do
    String.split(program, "\n", trim: true)
  end

  defp evaluate(instructions, registers, instruction_index)
       when instruction_index < length(instructions) do
    instruction = Enum.at(instructions, instruction_index)

    {new_registers, new_instruction_index} =
      case execute_instruction(registers, instruction) do
        {registers, new_index} -> {registers, new_index}
        registers -> {registers, instruction_index + 1}
      end

    evaluate(instructions, new_registers, new_instruction_index)
  end

  defp evaluate(_, registers, _out_of_bounds) do
    registers
  end

  defp execute_instruction(registers, "MOV " <> targets) do
    [target, value] = String.split(targets, " ", trim: true)

    value = value_or_register_value(registers, value)

    update_register(registers, target, value)
  end

  defp execute_instruction(registers, "ADD") do
    sum = read_register(registers, "A") + read_register(registers, "B")

    update_register(registers, @result_register, sum)
  end

  defp execute_instruction(registers, "MUL") do
    result = read_register(registers, "A") * read_register(registers, "B")

    update_register(registers, @result_register, result)
  end

  defp execute_instruction(registers, "JNZ " <> index) do
    if read_register(registers, @result_register) != 0 do
      execute_instruction(registers, "JMP #{index}")
    else
      registers
    end
  end

  defp execute_instruction(registers, "JMP " <> index) do
    {registers, String.to_integer(index)}
  end

  defp value_or_register_value(registers, value) when value in @registers do
    read_register(registers, value)
  end

  defp value_or_register_value(_registers, value) do
    value
  end

  defp update_register(registers, register, value) do
    target_index = register_index(register)

    List.replace_at(registers, target_index, normalize_value(value))
  end

  defp normalize_value(value) when is_binary(value), do: String.to_integer(value)
  defp normalize_value(value), do: value

  defp read_register(registers, register) do
    Enum.at(registers, register_index(register))
  end

  defp register_index(register) do
    Map.fetch!(@register_to_index, register)
  end

  # feels weird to have inspect here?
  # Let's us change the internal structure and maintain functionality.
  def inspect_registers(asm) do
    asm
  end
end
