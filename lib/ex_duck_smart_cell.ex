defmodule ExDuckSmartCell do
  @moduledoc false

  use Kino.JS, assets_path: "lib/assets/ex_duck_smart_cell"
  use Kino.JS.Live
  use Kino.SmartCell, name: "ExDuck"

  @impl true
  def init(attrs, ctx) do
    fields = %{
      "variable" => Kino.SmartCell.prefixed_var_name("results", attrs["variable"]),
      "topic" => attrs["topic"] || "",
    }

    {:ok, assign(ctx, fields: fields)}
  end

  @impl true
  def handle_connect(ctx) do
    payload = %{
      fields: ctx.assigns.fields
    }

    {:ok, payload, ctx}
  end

  @impl true
  def to_attrs(%{assigns: %{fields: fields}}) do
    Map.take(fields, ["topic", "variable"])
  end

  @impl true
  def to_source(attrs) do
    quote do
      unquote(quoted_var(attrs["variable"])) = ExDuck.answer!(unquote(attrs["topic"]))

      unquote(quoted_var(attrs["variable"]))
      |> ExDuck.to_markdown()
      |> Kino.Markdown.new()
    end |> Kino.SmartCell.quoted_to_string()
  end

  @impl true
  def handle_event("update_field", %{"field" => field, "value" => value}, ctx) do
    updated_fields = to_updates(ctx.assigns.fields, field, value)
    ctx = update(ctx, :fields, &Map.merge(&1, updated_fields))
    broadcast_event(ctx, "update", %{"fields" => updated_fields})
    {:noreply, ctx}
  end

  defp to_updates(fields, "variable", value) do
    if Kino.SmartCell.valid_variable_name?(value) do
      %{"variable" => value}
    else
      %{"variable" => fields["variable"]}
    end
  end

  defp to_updates(_fields, field, value), do: %{field => value}

  defp quoted_var(string), do: {String.to_atom(string), [], nil}
end
