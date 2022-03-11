defmodule LiveUiKit.UI.Table do
  use LiveUiKit.UI
  @moduledoc """
  Tables are used to display large sets of data in a structured way.
  """

  @doc ~S'''
  Table component:


  ## Examples

      <.table>
        <.thead>
          <.tr>
            <.th>User<./th>
            <.th>Role<./th>
          </.tr>
        </.thead>
        <.tbody>
          <.tr>
            <.td>Jane<./td>
            <.td>Admin<./td>
          </.tr>
        </.tbody>
      </.table>

  ## Options

    * `extended_class` - The class or classes that will be appended to the default class attribute.

    All further assigns will be passed to the table tag.
  '''
  def table(assigns) do
    assigns = config(assigns,
      component: "table",
      default_props: [],
      reserved_attrs: []
    )

    ~H"""
    <.table_wrapper>
      <table class={@class} {@extra_attrs}>
        <%= render_slot(@inner_block) %>
      </table>
    </.table_wrapper>
    """
  end

  @doc false
  def table_wrapper(assigns) do
    assigns = config(assigns, component: "table_wrapper")

    ~H"""
    <div class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  @doc "Se table for example usage"
  def thead(assigns) do
    assigns = config(assigns, component: "thead")

    ~H"""
    <thead class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </thead>
    """
  end

  @doc "Se table for example usage"
  def tbody(assigns) do
    assigns = config(assigns, component: "tbody")

    ~H"""
    <tbody class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </tbody>
    """
  end

  @doc "Se table for example usage"
  def tr(assigns) do
    assigns = config(assigns, component: "tr")

    ~H"""
    <tr class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </tr>
    """
  end

  @doc "Se table for example usage"
  def th(assigns) do
    assigns = config(assigns, component: "th", default_props: [scope: "col"])

    ~H"""
    <th scope={@scope} class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </th>
    """
  end

  @doc "Se table for example usage"
  def td(assigns) do
    assigns = config(assigns, component: "td")

    ~H"""
    <td class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </td>
    """
  end
end
