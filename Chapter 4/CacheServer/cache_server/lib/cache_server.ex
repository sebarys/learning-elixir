defmodule CacheServer.Server do
  use GenServer

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def read(pid) do
    GenServer.call(pid, :read_all)
  end

  def write(pid, person) do
    GenServer.cast(pid, {:add, person})
  end

  def delete(pid, person) do
    GenServer.cast(pid, {:delete, person})
  end

  def reset(pid) do
    GenServer.cast(pid, :reset_stats)
  end

  def exists?(pid, person) do
    GenServer.call(pid, {:exist, person})
  end

  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  def hello do
    :world
  end

  ## Server API
  def init(:ok) do
    {:ok, %MapSet{}}
  end

  def handle_call(:read_all, _from, stats) do
    {:reply, stats, stats}
  end

  def handle_call({:exist, person}, _from, stats) do
    {:reply, MapSet.member?(stats, person), stats}   
  end

  def handle_cast(:reset_stats, stats) do
    {:noreply, %MapSet{}}
  end

  def handle_cast({:add, person}, stats) do
    {:noreply, Set.put(stats, person)}
  end

  def handle_cast({:delete, person}, stats) do
    case MapSet.member?(stats, person) do
      true ->
        {:noreply, MapSet.delete(stats, person)}
      false ->
        {:noreply, stats}   
    end
  end

  def handle_cast(:stop, stats) do
    {:stop, :normal, stats}
  end

  def terminate(reason, stats) do
    IO.puts "termianting server: #{inspect reason}"
    inspect stats
    :ok
  end

  def handle_info(msg, stats) do
    IO.puts "received not handled message #{inspect msg}"
    {:noreply, stats}
  end


  ## Helper Functions

end