defmodule LiveUiKit.UI.Collapse do
  use LiveUiKit.UI
  @moduledoc """
  Collapse is used for toggle showing and hiding content.
  """

  @doc ~S'''
  Collapse component:


  ## Examples

      <button class="btn" phx-click={toggle_collapse("#collapse-one")}>
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

    All further assigns will be passed to the collapse tag.
  '''
  def collapse(assigns) do
    assigns = config(assigns, component: "collapse", reserved_attrs: [:"phx-hook", :"data-open", :"data-closed"])

    ~H"""
    <div id={@id} class={@class} phx-hook="Collapse" data-open={open(@id)} data-close={close(@id)} {@extra_attrs}>
      <%= render_slot(@inner_block, assigns) %>
    </div>
    """
  end

  def toggle_collapse(id, js \\ %JS{}) do
    js
    |> JS.dispatch("toggle-collapse", to: elm_id(id))
  end

  defp open(id, js \\ %JS{}) do
    js
    |> JS.set_attribute({"aria-expanded", "true"}, to: elm_id(id))
    |> JS.add_class("show", to: elm_id(id))
  end

  defp close(id, js \\ %JS{}) do
    js
    |> JS.set_attribute({"aria-expanded", "false"}, to: elm_id(id))
    |> JS.remove_class("show", to: elm_id(id))
  end
end
