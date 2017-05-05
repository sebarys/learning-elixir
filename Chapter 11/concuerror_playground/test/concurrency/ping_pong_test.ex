Code.require_file "test_helper.exs", __DIR__

defmodule PingPong.ConcurrencyTest do
	import PingPong
	use ExUnit.Case

	def test do
		ping_pid = spawn(fn -> ping end)
		spawn(fn -> pong(ping_pid) end)
	end

end