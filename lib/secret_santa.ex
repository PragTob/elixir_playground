defmodule SecretSanta do
  def draw(participants) do
    participants
    |> initial_draw
    |> fix_self_assignments
    |> Map.new()
  end

  defp initial_draw(participants) do
    randomized_participants = Enum.shuffle(participants)
    reversed_randomized_participants = Enum.reverse(randomized_participants)

    # zipping with the reversed randomized participants guarantees we have at most
    # one self assignment to fix and that's only if we have an odd number of
    # participants (most importantly it guarantees correct assignments)
    Enum.zip(randomized_participants, reversed_randomized_participants)
  end

  defp fix_self_assignments(assignments) do
    {self_assignments, correct_assignments} =
      Enum.split_with(assignments, fn {giver, receiver} -> giver == receiver end)

    do_fix_self_assignment(self_assignments, correct_assignments)
  end

  defp do_fix_self_assignment(self_assignments, correct_assignments)
  defp do_fix_self_assignment([], correct_assignments), do: correct_assignments

  defp do_fix_self_assignment(self_assignments, correct_assignments) do
    # we're sure we only have one self assignment due to the reverse trick in initial_draw/1
    [{self_assigned, self_assigned}] = self_assignments

    [{giver_name, receiver_name} | other_assignments] = correct_assignments

    [{self_assigned, receiver_name}, {giver_name, self_assigned} | other_assignments]
  end
end
