defmodule SimpleQueue do
  alias SimpleQueue.Queue

  @moduledoc """
  Documentation for `SimpleQueue`.
  """

  @doc """
  Start the queue.

  ## Examples

      _iex> SimpleQueue.start_link()
      {:ok, #PID<0.303.0>}

  """
  defdelegate start_link(intial_queue), to: Queue, as: :start_link

  @doc """
  Enqueue an element.

  ## Examples

      _iex> SimpleQueue.enqueue(pid, 1)
      :ok

  """
  defdelegate enqueue(pid, element), to: Queue, as: :enqueue

  @doc """
  Dequeue an element.

  ## Examples

      _iex> SimpleQueue.dequeue(pid)
      1

  """
  defdelegate dequeue(pid), to: Queue, as: :dequeue
end
