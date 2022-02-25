defmodule LiveUiKit.UI.Alert do
  use LiveUiKit.UI
  @moduledoc """
  Alerts provide contextual feedback messages to users for common
  user actions using the few available and flexible alert messages.
  """

  @doc ~S'''
  Alert component:


  ## Examples

      <.alert>
        Default alert
      </.alert>

      <.alert variant="success" extended_class="font-bold text-2xl">
        Success alert
      </.alert>

      <.alert variant="warning">
        Warning!!
      </.alert>

      <.alert>
        <:icon>
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="#2196f3" class="block w-6 h-6 mx-2 align-middle">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
        </:icon>
        Alert with icon
      </.alert>

  ## Options

    * `variant` - The variant of the alert. Possible options are 'info', 'success',
      'warning' and 'error'. Default is 'info'.
    * `icon` - A slot to display an icon.
    * `extended_class` - The class or classes that will be appended to the default class attribute.

    All further assigns will be passed to the alert tag.
  '''
  def alert(assigns) do
    assigns = config(assigns,
      component: "alert",
      default_props: [variant: "info", icon: nil],
      reserved_attrs: [:icon, :variant, :role]
    )

    ~H"""
    <div class={@class} role="alert" {@extra_attrs}>
      <%= if @icon do %>
        <div class="flex flex-1">
          <%= render_slot(@icon) %>
          <label>
            <%= render_slot(@inner_block) %>
          </label>
        </div>
      <% else %>
        <label>
          <%= render_slot(@inner_block) %>
        </label>
      <% end %>
    </div>
    """
  end
end
