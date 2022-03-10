defmodule LiveUiKit.UI.Icon do
  use LiveUiKit.UI
  @moduledoc """
  Icons use the bootstrap icons from https://icons.getbootstrap.com
  """

  @before_compile LiveUiKit.IconLoader

  @doc ~S'''
  Icon component:

  ## Examples

      <.icon name="apple" />
      <.icon name="alarm" class="inline w-6 h-6" />

  '''
  def icon(assigns) do
    assigns = config(assigns,
      component: "icon",
      default_props: [name: "question-lg", width: 16, height: 16]
    )

    ~H"""
    <%= get_icon(@name, class: @class, width: @width, height: @height) %>
    """
  end

  defp get_icon(name, opts), do: get_icon(name, opts, nil)
end
