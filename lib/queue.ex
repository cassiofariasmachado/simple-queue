defmodule SimpleQueue.Queue do
  use GenServer

  # Client

  def start_link(initial_queue) when is_list(initial_queue) do
    GenServer.start_link(__MODULE__, initial_queue)
  end

  def start_link(_initial_queue), do: {:error, "Invalid initial queue"}

  def enqueue(pid, element) do
    GenServer.cast(pid, {:enqueue, element})
  end

  def dequeue(pid) do
    with {:ok, element} <- GenServer.call(pid, :dequeue) do
      element
    end
  end

  # Server

  @impl true
  def init(initial_queue) do
    {:ok, initial_queue}
  end

  @impl true
  def handle_cast({:enqueue, element}, queue) do
    new_queue = queue ++ [element]
    {:noreply, new_queue}
  end

  @impl true
  def handle_call(:dequeue, _from, [head | tail]) do
    {:reply, {:ok, head}, tail}
  end

  @impl true
  def handle_call(:dequeue, _from, []) do
    {:reply, {:ok, nil}, []}
  end

  @impl true
  def handle_call(_request, _from, queue) do
    {:reply, {:error, "Invalid request"}, queue}
  end
end
