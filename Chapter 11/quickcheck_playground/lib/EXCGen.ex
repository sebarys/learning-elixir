defmodule EQCGen do
	use EQC.ExUnit

	def string_with_fixed_length(len) do
		vector(len, char)
	end

	def string_with_variable_length do
		# let binds generated value to use by another generator it must be here,
		# first argument should be integer not generator
		let len <- choose(1, 10) do
			vector(len, oneof(:lists.seq(?a, ?z) ++ (?,)))
		end
	end

	def lowercase_only_string(len) do
		vector(len, oneof(:lists.seq(?a, ?z)))
	end

	def lowercase_and_comma_only_string(len) do
		vector(len, oneof(:lists.seq(?a, ?z) ++ (?,)))
	end

	def lowercase_and_commas_with_variable_length do
		let len <- choose(1, 20) do
			vector(len, frequency([ {3, oneof(:lists.seq(?a, ?z))},
									{1, ?,} ]))
		end
	end
end