# SimpleQueue

Repository for the eighteen challenge of the Elixir's path from [Rocketseat Ignite](https://rocketseat.com.br).

## :rocket: Techs

* [Elixir](https://elixir-lang.org/)

## :wrench: Setup

  * Install dependencies with `mix deps.get`
  * For interactive testing use `iex -S mix`

## :white_check_mark: Test

To run tests:

* Run with `mix test --cover`

## :man_technologist: Usage

### Start queue

```elixir
{:ok, pid} = SimpleQueue.start_link([])
```

### Enqueue an element

```elixir
SimpleQueue.enqueue(pid, 1)
# :ok
```

### Dequeue

```elixir
SimpleQueue.dequeue(pid)
# 1
```

## :page_facing_up: License

* [MIT](/LICENSE.txt)



