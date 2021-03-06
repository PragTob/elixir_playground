defmodule SecretSantaTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  import StreamData
  import SecretSanta

  require Assertions
  import Assertions, only: [assert_lists_equal: 2]

  describe "draw/1" do
    property "assignments are the same size as the input" do
      check all participants <- participant_list() do
        assignment = draw(participants)
        assert map_size(assignment) == length(participants)
      end
    end

    property "every participant is a giver exactly once" do
      check all participants <- participant_list() do
        assignment = draw(participants)

        givers = Map.keys(assignment)
        assert_lists_equal(givers, participants)
      end
    end

    property "every participant is a receiver exactly once" do
      check all participants <- participant_list() do
        assignment = draw(participants)

        receivers = Map.values(assignment)
        assert_lists_equal(receivers, participants)
      end
    end

    property "people aren't going to gift themselves" do
      check all participants <- participant_list() do
        assignment = draw(participants)

        Enum.each(assignment, fn {giver, receiver} ->
          refute giver == receiver
        end)
      end
    end
  end

  defp participant_list do
    uniq_list_of(string(:alphanumeric, min_length: 1), min_length: 2)
  end
end
