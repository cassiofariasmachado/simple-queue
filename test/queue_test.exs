defmodule SimpleQueue.QueueTest do
  use ExUnit.Case

  alias SimpleQueue.Queue

  describe "start_link/1" do
    test "when intial queue is valid, starts the server" do
      response = Queue.start_link([1, 2, 3])

      assert {:ok, _pid} = response
    end

    test "when intial queue is not valid, returns an error" do
      response = Queue.start_link(%{})

      expected_response = {:error, "Invalid initial queue"}

      assert expected_response == response
    end
  end

  describe "enqueue/2" do
    setup %{} do
      {:ok, pid} = Queue.start_link([])

      {:ok, pid: pid}
    end

    test "enqueue the element", %{pid: pid} do
      response = Queue.enqueue(pid, 1)

      assert :ok == response
    end
  end

  describe "dequeue/1" do
    test "when queue has elements, dequeue the element" do
      {:ok, pid} = Queue.start_link([1, 2, 3])

      response = Queue.dequeue(pid)

      assert 1 == response
    end

    test "when queue has no elements, returns nil" do
      {:ok, pid} = Queue.start_link([])

      response = Queue.dequeue(pid)

      assert nil == response
    end
  end

  describe "handle_cast/2" do
    test "enqueue the element" do
      response = Queue.handle_cast({:enqueue, 2}, [1])

      expected_response = {:noreply, [1, 2]}

      assert expected_response == response
    end
  end

  describe "handle_call/3" do
    test "when the request is valid, dequeue the element" do
      response = Queue.handle_call(:dequeue, "from", [1, 2, 3])

      expected_response = {:reply, {:ok, 1}, [2, 3]}

      assert expected_response == response
    end

    test "when the request is valid and queue has no elements, returns nil" do
      response = Queue.handle_call(:dequeue, "from", [])

      expected_response = {:reply, {:ok, nil}, []}

      assert expected_response == response
    end

    test "when the request is invalid, returns an error" do
      response = Queue.handle_call(:xpto, "from", [1, 2, 3])

      expected_response = {:reply, {:error, "Invalid request"}, [1, 2, 3]}

      assert expected_response == response
    end
  end
end
