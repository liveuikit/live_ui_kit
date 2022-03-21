defmodule LiveUiKit.DataTableHelpers do
  @moduledoc false

  @doc false
  def sort(%{"sort_field" => field, "sort_direction" => direction}) when direction in ~w(asc desc) do
    {String.to_atom(direction), String.to_existing_atom(field)}
  end

  def sort(_other) do
    {:asc, :id}
  end

  @doc false
  def opts_from_params(%{} = sort_params, field) do
    sort_field = Map.get(sort_params, "sort_field", "")
    direction = Map.get(sort_params, "sort_direction")

    [
      page: nil,
      sort_field: field,
      sort_direction: (if sort_field == to_string(field), do: reverse(direction), else: "desc")
    ]
  end

  def querystring(params, opts \\ %{}) do
    params = params |> Plug.Conn.Query.encode() |> URI.decode_query()

    opts = %{
      "page" => opts[:page], # For the pagination
      "sort_field" => opts[:sort_field] || params["sort_field"] || nil,
      "sort_direction" => opts[:sort_direction] || params["sort_direction"] || nil
    }

    params
    |> Map.merge(opts) # map
    |> Enum.filter(fn {_, v} -> v != nil end) # returns a list of tuples
    |> Enum.into(%{}) # back into map
    |> URI.encode_query() # string
  end

  defp reverse("desc"), do: "asc"
  defp reverse(_), do: "desc"
end
