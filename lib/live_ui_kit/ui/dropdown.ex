defmodule LiveUiKit.UI.Dropdown do
  use LiveUiKit.UI
  @moduledoc """
  Dropdown can open a menu or any other element when the button is clicked.
  """

  @doc ~S'''
  Dropdown component:


  ## Examples

      <button class="btn" phx-click={UI.Collapse.toggle("#collapse-one")}>
        Toggle Collapse
      </button>

      <.collapse id="collapse-one">
        <.card>
          <.card_body>
            Some placeholder content for the collapse component. This panel
            is hidden by default but revealed when the user activates the relevant trigger.
          </.card_body>
        </.card>
      </.collapse>

  ## Options

    * `extended_class` - The class or classes that will be appended to the default class attribute.

    All further assigns will be passed to the dropdown tag.
  '''
  def dropdown(assigns) do
    assigns = config(assigns,
      component: "dropdown",
      default_props: [align: "left", toggle: nil, label: nil],
      reserved_attrs: [:toggle]
    )

    ~H"""
    <div class={@class} {@extra_attrs}>
      <%= if @toggle do %>
        <.dropdown_toggle id={@id}>
          <%= render_slot(@toggle) %>
        </.dropdown_toggle>
      <% end %>
      <%= if is_nil(@toggle) && @label do %>
        <.dropdown_toggle id={@id}>
          <%= @label %>
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="w-3 h-3 ml-1 bi bi-caret-down-fill" viewBox="0 0 16 16">
            <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
          </svg>
        </.dropdown_toggle>
      <% end %>
      <div id={@id} class="absolute left-0 z-20 hidden" phx-click-away={hide(@id)}>
        <%= render_slot(@inner_block, assigns) %>
      </div>
    </div>
    """
  end

  def dropdown_toggle(assigns) do
    assigns = config(assigns, component: "dropdown_toggle", reserved_attrs: [:"phx-click"])
    ~H"""
    <button phx-click={toggle(@id)} class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block, assigns) %>
    </button>
    """
  end

  def dropdown_menu(assigns) do
    assigns = config(assigns, component: "dropdown_menu")
    ~H"""
    <ul class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block, assigns) %>
    </ul>
    """
  end

  defp toggle(id, js \\ %JS{}) do
    js
    |> JS.toggle(
      to: "##{id}",
      in: {"duration-300", "opacity-0", "opacity-100"},
      out: {"duration-75", "opacity-100", "opacity-0"}
    )
  end

  defp hide(id, js \\ %JS{}) do
    js
    |> JS.hide(to: "##{id}", transition: {"duration-75", "opacity-100", "opacity-0"})
  end
end
