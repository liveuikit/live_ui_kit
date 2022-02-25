defmodule LiveUiKit.UI.Badge do
  use LiveUiKit.UI
  @moduledoc """
  Badges are used to inform user of the status of specific data.
  """

  @doc ~S'''
  Badge component:


  ## Examples

      <.badge>
        Default alert
      </.badge>

      <.badge variant="success">
        Success badge
      </.badge>

      <.badge variant="warning">
        Warning!!
      </.badge>


  ## Options

    * `variant` - The variant of the badge Possible options are 'info', 'success',
      'warning' and 'error'. Default is 'primary'.
    * `extended_class` - The class or classes that will be appended to the default class attribute.

    All further assigns will be passed to the alert tag.
  '''
  def badge(assigns) do
    assigns = config(assigns,
      component: "badge",
      default_props: [variant: "primary"],
      reserved_attrs: [:variant]
    )

    ~H"""
    <span class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end
end
