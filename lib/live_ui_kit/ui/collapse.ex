defmodule LiveUiKit.UI.Collapse do
  use LiveUiKit.UI
  @moduledoc """
  Collapse is used for toggle showing and hiding content.
  """

  @doc ~S'''
  Collapse component:


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

    All further assigns will be passed to the collapse tag.
  '''
  def collapse(assigns) do
    assigns = config(assigns, component: "collapse", reserved_attrs: [:"phx-hook"])

    ~H"""
    <div id={@id} class={@class} phx-hook="Collapse" {@extra_attrs}>
      <%= render_slot(@inner_block, assigns) %>
    </div>
    """
  end

  def toggle(id, js \\ %JS{}) do
    id = String.replace_leading(id, "#", "")

    js
    |> JS.dispatch("toggle-collapse", to: "##{id}")
  end
end
