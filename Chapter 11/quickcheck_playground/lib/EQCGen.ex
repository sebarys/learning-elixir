defmodule EQCGen do
	use EQC.ExUnit

	def balanced_tree(gen) do
		sized size do
			balanced_tree(size, gen)
		end
	end

	def balanced_tree(0, gen) do
		{:leaf, gen}
	end

	def balanced_tree(n, gen) do
		lazy do
			{
				:node,
				gen, 
				balanced_tree(div(n, 2), gen),
				balanced_tree(div(n,2), gen)
			}
		end
	end
end