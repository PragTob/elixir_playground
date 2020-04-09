defmodule RASMTest do
  use ExUnit.Case, async: true

  describe "run_program/1" do
    test "test_add" do
      program = """
      MOV A 10
      MOV B 15
      ADD
      """

      asm = RASM.run_program(program)
      assert [10, 15, 25] == RASM.inspect_registers(asm)
    end

    test "test_harder_add" do
      program = """
      MOV A 10
      MOV B 15
      MOV A B
      ADD
      """

      asm = RASM.run_program(program)
      assert [15, 15, 30] == RASM.inspect_registers(asm)
    end

    test "test_mul" do
      program = """
      MOV A 10
      MOV B 15
      MUL
      """

      asm = RASM.run_program(program)
      assert [10, 15, 150] == RASM.inspect_registers(asm)
    end

    test "test_jnz_1" do
      program = """
      MOV A 10
      MOV B 15
      MOV C 1
      JNZ 5
      MUL
      ADD
      """

      asm = RASM.run_program(program)
      assert [10, 15, 25] == RASM.inspect_registers(asm)
    end

    test "test_jnz_2" do
      program = """
      MOV A 10
      MOV B 15
      MOV C 0
      JNZ 5
      MUL
      JNZ 7
      ADD
      """

      asm = RASM.run_program(program)
      assert [10, 15, 150] == RASM.inspect_registers(asm)
    end

    test "test_jmp_1" do
      program = """
      MOV A 10
      MOV B 15
      MOV C 0
      JMP 5
      MUL
      JMP 7
      ADD
      """

      asm = RASM.run_program(program)
      assert [10, 15, 0] == RASM.inspect_registers(asm)
    end

    test "test_jmp_2" do
      program = """
      MOV A 1
      MOV B 2
      JMP 5
      ADD
      JMP 6
      JMP 3
      MOV B 10
      """

      asm = RASM.run_program(program)
      assert [1, 10, 3] == RASM.inspect_registers(asm)
    end
  end
end
