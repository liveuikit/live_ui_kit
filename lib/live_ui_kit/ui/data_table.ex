defmodule LiveUiKit.UI.DataTable do
  use LiveUiKit.UI
  @moduledoc """
  Data tables are used to display large sets of data in a structured way
  with sorting and pagination.
  """

  import LiveUiKit.UI.Table
  import LiveUiKit.DataTableHelpers

  @doc ~S'''
  Data Table Head component. Make sure to add params. Params is a map that
  can be taken from tre handle_params callback


  ## Examples

      <.table>
        <.data_table_head params={@params}>
          <:th label="User" sort={:user} class="flex items-center" />
          <:th label="Role" sort={:role} />
        </.data_table_head>
        <.tbody>
          <.tr>
            <.td>Jane<./td>
            <.td>Admin<./td>
          </.tr>
        </.tbody>
      </.table>

  ## Options

    * `extended_class` - The class or classes that will be appended to the default class attribute.

    All further assigns will be passed to the table tag.
  '''
  def data_table_head(assigns) do
    assigns = config(assigns,
      component: "thead",
      reserved_attrs: [:params, :th],
      default_props: [th: [], params: nil]
    )

    ~H"""
    <thead class={@class} {@extra_attrs}>
      <%= if is_list(@th) && length(@th) > 0 do %>
        <.tr>
          <%= for th <- @th do %>
            <%= if th[:sort] do %>
              <.th>
                <.data_table_link sort={th[:sort]} params={@params} class={th[:class]}>
                  <%= th[:label] %>
                </.data_table_link>
              </.th>
            <% else %>
              <th><%= th[:label] %></th>
            <% end %>
          <% end %>
        </.tr>
      <% end %>

      <%= render_slot(@inner_block) %>
    </thead>
    """
  end

  def data_table_link(assigns) do
    assigns = config(assigns,
      component: "data_table_link",
      default_props: [params: %{}],
      reserved_attrs: [:params, :sort]
    )

    params = Map.get(assigns, :params, %{})
    sort_by = Map.get(assigns, :sort)

    assigns =
      assigns
      |> assign_new(:querystring, fn ->
        opts = opts_from_params(params, sort_by)
        "?#{querystring(params, opts)}"
      end)

    ~H"""
    <a class={@class} data-phx-link="patch" data-phx-link-state="push" href={@querystring}>
      <%= render_slot(@inner_block) %>
    </a>
    """
  end
end
