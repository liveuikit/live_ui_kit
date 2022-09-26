defmodule LiveUiKit.UI.Accordion do
  use LiveUiKit.UI
  @moduledoc """
  Dropdown can open a menu or any other element when the button is clicked.
  """

  @doc ~S'''
  Dropdown component:


  ## Examples

      <.dropdown label="Some Dropdown">
        <.dropdown_menu>
          <li>
            <a href="#">Settings</a>
          </li>
          <li>
            <a href="#">Sign Out</a>
          </li>
        </.dropdown_menu>
      </.dropdown>

  ## Options

    * `label` - If provided, it can use the label string as the toggle text.
    * `toggle_class` - The class or classes that will be appended to the toggle element.
    * `extended_class` - The class or classes that will be appended to the default class attribute.

    All further assigns will be passed to the dropdown tag.
  '''

  def accordion(assigns) do
    assigns = config(assigns,
      component: "accordion",
      default_props: [],
      reserved_attrs: []
    )

    ~H"""
    <div>
    </div>
    """
  end
end
