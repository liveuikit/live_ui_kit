defmodule LiveUiKit.UI do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      use Phoenix.Component
      import Phoenix.HTML
      import LiveUiKit, only: [config: 2, elm_id: 1]
      alias Phoenix.LiveView.JS
    end
  end
end
