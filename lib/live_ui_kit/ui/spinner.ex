defmodule LiveUiKit.UI.Spinner do
  use LiveUiKit.UI
  @moduledoc """
  Spinners indicate the loading state of a component or page.
  """

  @doc ~S'''
  Spinner component:


  ## Examples

      <.spinner />
      <.spinner visible={false} />
      <.spinner class="w-8 h-8 text-primary animate-spin" />
      <.spinner extended_class="mr-4" />

  ## Options

    * `visible` - Determines if the spinner should be rendered.
    * `extended_class` - The class or classes that will be appended to the default class attribute.

    All further assigns will be passed to the spinner tag.
  '''
  def spinner(assigns) do
    assigns = config(assigns,
      component: "spinner",
      default_props: [visible: true],
      reserved_attrs: [:role, :xmlns, :fill, :viewBox, :visible]
    )

    ~H"""
    <%= if @visible do %>
      <svg id={@id} class={@class} role="status" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" {@extra_attrs}>
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
    <% end %>
    """
  end
end
