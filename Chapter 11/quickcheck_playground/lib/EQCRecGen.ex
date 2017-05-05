defmodule EQCRecGen do
	use EQC.ExUnit

	def nested_list(gen) do
		sized size do
			nested_list(size, gen)
		end
	end

	defp nested_list(0, _gen) do
		[]
	end

	defp nested_list(n, gen) do
		lazy do
			oneof [[gen | nested_list(n-1, gen)],
					[nested_list(n-1, gen)]]	
		end
	end
end