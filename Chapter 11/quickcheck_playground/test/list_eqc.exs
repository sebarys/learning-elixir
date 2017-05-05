defmodule ListEQC do
	use ExUnit.Case
	use EQC.ExUnit

	property "reversing a list twice yields the original list" do
		forall i <- list(int) do
			ensure i |> Enum.reverse |> Enum.reverse == i
		end
	end
end