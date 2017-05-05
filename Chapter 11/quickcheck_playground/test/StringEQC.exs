defmodule StringEQC do
	use ExUnit.Case
	use EQC.ExUnit

	property "splittin a string with a delimiter and joining it again yileds the same string naive version" do
		forall s <- list(char) do
			s = to_string(s)
			ensure String.split(s, ",") |> join(",") == s
		end
	end

	property "splitting a string with a delimiter and joining it again yileds the same string" do
		forall s <- EQCGen.lowercase_and_commas_with_variable_length do
			s = to_string(s)
			:eqc.classify(String.contains?(s, ","),
						  :string_with_commas,
						  ensure String.split(s, ",") |> join(",") == s)
		end
	end

	defp join(parts, delimiter) do
		parts |> Enum.intersperse([delimiter]) |> Enum.join
	end
end