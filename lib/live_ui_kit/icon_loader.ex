defmodule LiveUiKit.IconLoader do
  @moduledoc false

  @doc false
  defmacro __before_compile__(%Macro.Env{module: _module}) do
    icon_dir = "icons/"
    default_attrs = [
      xmlns: "http://www.w3.org/2000/svg",
      width: 16,
      height: 16,
      fill: "currentColor",
      class: "",
      viewBox: "0 0 16 16"
    ]

    icon_paths =
      Path.absname(icon_dir, :code.priv_dir(:live_ui_kit))
      |> Path.join("*.svg")
      |> Path.wildcard()

    for path <- icon_paths do
      generate_function(path, default_attrs)
    end
  end

  @doc false
  def generate_function(path, default_attrs) do
    name =
      Path.basename(path, ".svg")

    icon = File.read!(path)
    {i, _} = :binary.match(icon, ">")
    {_, body} = String.split_at(icon, i)

    default_class = "bi bi-#{name}"

    quote do
      @doc false
      defp get_icon(unquote(name), opts, _) do
        opts =
          Keyword.merge(unquote(default_attrs), opts)
          |> Keyword.update(
            :class,
            unquote(default_class),
            fn v -> Enum.join([unquote(default_class), v], " ") |> String.trim() end
          )

        attrs =
          for {k, v} <- opts do
            safe_k =
              k |> Atom.to_string() |> String.replace("_", "-") |> Phoenix.HTML.Safe.to_iodata()

            safe_v = v |> Phoenix.HTML.Safe.to_iodata()

            {:safe, [?\s, safe_k, ?=, ?", safe_v, ?"]}
          end

        {:safe, ["<svg", Phoenix.HTML.Safe.to_iodata(attrs), unquote(body)]}
      end
    end
  end
end
