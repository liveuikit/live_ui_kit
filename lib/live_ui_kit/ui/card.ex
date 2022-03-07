defmodule LiveUiKit.UI.Card do
  use LiveUiKit.UI
  @moduledoc """
  Cards are used to group and display content in a way that is easily readable.
  """

  @doc ~S'''
  Card component. A card component can contain card_body, card_header, card_footer.

  ## Examples

      <.card>
        <.card_body>
          Basic card with body
        </.card_body>
      </.card>

       <.card_body>
          <.card_title>
            Card Title
          </.card_title>
          Some quick example text to build on the card title and make up the bulk of the card's content.
        </.card_body>
      </.card>

      <.card>
        <.card_body title="Card Title">
          Some quick example text to build on the card title and make up the bulk of the card's content.
        </.card_body>
      </.card>

      <.card>
        <a href="#!">
          <img class="rounded-t-lg" src="https://mdbootstrap.com/img/new/standard/nature/184.jpg" alt=""/>
        </a>
        <.card_body>
          <h5 class="mb-2 text-xl font-medium text-gray-900">Card Title</h5>
          <p class="mb-4 text-base text-gray-700">
            Some quick example text to build on the card title and make up the bulk of the card's
            content.
          </p>
        </.card_body>
      </.card>

      <.card header="Header Text">
        <.card_body>
          Card with header and body
        </.card_body>
      </.card>

      <.card footer="Footer text">
        <.card_body>
          Card with header and body
        </.card_body>
      </.card>

  ## Options

    * `header` - Passing in a header text will act as a <.card_header>.
    * `footer` - Passing in a footer text will act as a <.card_footer>.
    * `extended_class` - The class or classes that will be appended to the default class attribute.

  All further assigns will be passed to the card tag.
  '''
  def card(assigns) do
    assigns = config(assigns, component: "card", default_props: [header: nil, footer: nil])

    ~H"""
    <div class={@class} {@extra_attrs}>
      <%= if @header do %>
        <.card_header><%= @header %></.card_header>
      <% end %>
      <%= render_slot(@inner_block) %>
      <%= if @footer do %>
        <.card_footer><%= @footer %></.card_footer>
      <% end %>
    </div>
    """
  end

  @doc ~S'''
  Card header component.

  ## Options

    * `extended_class` - The class or classes that will be appended to the default class attribute.

  All further assigns will be passed to the card header tag.
  '''
  def card_header(assigns) do
    assigns = config(assigns, component: "card_header")

    ~H"""
    <div class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  @doc ~S'''
  Card footer component.

  ## Options

    * `extended_class` - The class or classes that will be appended to the default class attribute.

  All further assigns will be passed to the card footer tag.
  '''
  def card_footer(assigns) do
    assigns = config(assigns, component: "card_footer")

    ~H"""
    <div class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  @doc ~S'''
  Card title component.

  ## Options

    * `extended_class` - The class or classes that will be appended to the default class attribute.

  All further assigns will be passed to the card title tag.
  '''
  def card_title(assigns) do
    assigns = config(assigns, component: "card_title")

    ~H"""
    <h5 class={@class} {@extra_attrs}>
      <%= render_slot(@inner_block) %>
    </h5>
    """
  end

  @doc ~S'''
  Card body component.

  ## Options

    * `title` - Passing in a title text will act as a <.card_title>.
    * `extended_class` - The class or classes that will be appended to the default class attribute.

  All further assigns will be passed to the card body tag.
  '''
  def card_body(assigns) do
    assigns = config(assigns, component: "card_body", default_props: [title: nil])

    ~H"""
    <div class={@class} {@extra_attrs}>
      <%= if @title do %>
        <.card_title><%= @title %></.card_title>
      <% end %>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
