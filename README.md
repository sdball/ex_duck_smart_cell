# ExDuckSmartCell

An Elixir Livebook smart cell interface for [ExDuck](https://github.com/sdball/ex_duck)

## Installation

ExDuckSmartCell can be installed by adding `ex_duck_smart_cell` to your list of
dependencies in your Livebook setup section:

```elixir
Mix.install([
  {:ex_duck_smart_cell, "~> 0.1.2"}
])
```

Outside of Livebook you can add `ex_duck_smart_cell` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_duck_smart_cell, "~> 0.1.2"}
  ]
end
```

## Documentation

ExDuckSmartCell documentation can be found at
<https://hexdocs.pm/ex_duck_smart_cell>.

## Usage

Add this package to your Livebook setup section. Then you'll have an "ExDuck" smart cell available.

Query for a given topic and the results will be displayed in markdown directly in your Livebook and the underlying data map will be assigned to the given variable name.

![ExDuck smart cell showing a query and results for "Elixir Language"](https://github.com/sdball/ex_duck_smart_cell/raw/main/example.png)

