defmodule LiveUiKit.UI.Modal do
  use LiveUiKit.UI
  @moduledoc """
  Modal is used to show a dialog or a box when you click a button.
  """

  @doc ~S'''
  Modal component:


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
  def modal(assigns) do
    assigns = config(assigns,
      component: "modal",
      default_props: [
        return_to: nil,
        header: false,
        visible: false,
        backdrop: true,
        title: nil,
      ],
      reserved_attrs: [:style, :role, :"data-init-modal", :"phx-remove"]
    )

    id = Map.get(assigns, :id)

    assigns =
      assigns
      |> assign(:close_id, "#{id}-close")
      |> assign(:close_id, "#{id}-content")

    ~H"""
    <div class={@class} id={@id} role="dialog" data-init-modal={open_modal()} phx-remove={close_modal()} style="display: none">
      <.modal_backdrop visible={@backdrop} />
      <.modal_dialog>
        <.modal_content>
          <div class="relative flex flex-col w-full border rounded-lg pointer-events-auto text-base-content bg-base-100 border-base-200">
            <.modal_header>
              <.modal_title>
                <%= if assigns[:modal_title], do: render_slot(@modal_title), else: @title %>
              </.modal_title>
              <%= if @return_to do %>
                <%= live_patch raw("&times;"), to: @return_to, phx_click: close_modal(), id: "close", class: "" %>
              <% else %>
                <button type="button" id="close" phx-click={close_modal()}>&times;</button>
              <% end %>
            </.modal_header>
            <.modal_body>
              <%= render_slot(@inner_block, assigns) %>
            </.modal_body>
          </div>
        </.modal_content>
      </.modal_dialog>
    </div>
    """
  end

  def modal_dialog(assigns) do
    assigns = config(assigns, component: "modal_dialog")

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def modal_backdrop(assigns) do
    assigns = config(assigns, component: "modal_backdrop")

    ~H"""
    <%= if @visible do %>
      <div class={@class}></div>
    <% else %>
      <div></div>
    <% end %>
    """
  end

  def modal_content(assigns) do
    assigns = config(assigns, component: "modal_content")

    ~H"""
    <div id="modal-content" class={@class} phx-click-away={JS.dispatch("click", to: "#close")} phx-window-keydown={JS.dispatch("click", to: "#close")} phx-key="escape">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def modal_header(assigns) do
    assigns = config(assigns, component: "modal_header")

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def modal_title(assigns) do
    assigns = config(assigns, component: "modal_title")

    ~H"""
    <h5 class={@class}>
      <%= render_slot(@inner_block) %>
    </h5>
    """
  end

  def modal_body(assigns) do
    assigns = config(assigns, component: "modal_body")

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def open(_id, js \\ %JS{}) do
    js
    |> JS.show(to: "#modal")
    |> JS.show(to: "#modal-content")
    |> open_modal()
  end

  defp open_modal(js \\ %JS{}) do
    js
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.transition("fade-in", to: "#modal")
    |> JS.transition("modal-content-in", to: "#modal-content")
  end

  defp close_modal(js \\ %JS{}) do
    js
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "modal-content-out")
  end
end
