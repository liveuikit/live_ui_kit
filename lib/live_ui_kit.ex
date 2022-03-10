defmodule LiveUiKit do
  @moduledoc File.read!("README.md") |> String.split("<!-- MDOC !-->") |> Enum.fetch!(1)

  @before_compile LiveUiKit.ClassLoader

  @themes [:tailwind, :bootstrap, :daisyui]

  defmacro __using__(_opts) do
    quote do
      alias LiveUiKit.UI

      import UI.Accordion
      import UI.Alert
      import UI.Avatar
      import UI.Badge
      import UI.Button
      import UI.Card
      import UI.Collapse
      import UI.Dropdown
      import UI.Icon
      import UI.Modal
      import UI.Table
      import UI.Tabs
      import UI.Toast
    end
  end

  import Phoenix.LiveView, only: [assign: 3, assign_new: 3]
  import Phoenix.LiveView.Helpers, only: [assigns_to_attributes: 2]

  @doc false
  def config(assigns, opts \\ []) do
    assigns
    |> maybe_assign_dom_id()
    |> (&require_props(&1, Keyword.get(opts, :required_props, []))).()
    |> (&default_props(&1, Keyword.get(opts, :default_props, []))).()
    |> (&get_extra_attrs(&1, Keyword.get(opts, :reserved_attrs, []))).()
    |> (&default_class(&1, Keyword.get(opts, :component, nil))).()
    |> maybe_assign_extended_class()
  end

  @doc false
  def elm_id("#" <> id), do: "##{id}"
  def elm_id("" <> id), do: "##{id}"

  defp maybe_assign_dom_id(assigns) do
    assigns
    |> assign_new(:id, fn -> "dom#{System.unique_integer()}" end)
  end

  defp require_props(assigns, _props) do
    assigns
  end

  defp default_props(assigns, []), do: assigns
  defp default_props(assigns, [_|_] = props) do
    Enum.reduce(props, assigns, fn ({prop, default}, acc) ->
      acc |> assign_new(prop, fn -> default end)
    end)
  end

  defp default_class(assigns, nil), do: assigns
  defp default_class(assigns, component) do
    base_class = get_in(base_css(), [component, "base"])
    variant = Map.get(assigns, :variant, "")
    variant_class =
      get_in(base_css(), [component, variant]) || get_in(base_css(), [component, "variant", variant])

    assigns
    |> assign_new(:class, fn ->
      String.trim("#{base_class} #{variant_class}")
    end)
  end

  defp maybe_assign_extended_class(assigns) do
    case Map.get(assigns, :extended_class) do
      nil ->
        assigns
      "" <> extended_class ->
        class = "#{Map.get(assigns, :class)} #{extended_class}" |> String.trim()

        assigns
        |> assign(:class, class)
    end
  end

  defp get_extra_attrs(assigns, reserved_attrs) when is_list(reserved_attrs) do
    extra = assigns_to_attributes(assigns, ([:id, :class] ++ reserved_attrs))
    assign(assigns, :extra_attrs, extra)
  end

  defp base_css() do
    # CHECK FOR OVERRIDE LAST
    # THEN MERGE THE MAPS
    theme = get_base_css_from_teme(Application.get_env(:live_ui_kit, :theme))

    theme
  end

  @doc false
  def get_base_css_from_teme("bootstrap"), do: bootstrap()
  def get_base_css_from_teme(:bootstrap), do: bootstrap()
  def get_base_css_from_teme("daisyui"), do: daisyui()
  def get_base_css_from_teme(:daisyui), do: daisyui()
  def get_base_css_from_teme(_), do: tailwind()
end
