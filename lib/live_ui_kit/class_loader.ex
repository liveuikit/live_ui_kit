defmodule LiveUiKit.ClassLoader do
  @moduledoc false

  @doc false
  defmacro __before_compile__(%Macro.Env{module: module}) do
    for theme <- Module.get_attribute(module, :themes) do
      content = YamlElixir.read_from_file!("priv/#{theme}.yml")
      generate_function(theme, content)
    end
  end

  def generate_function(theme_name, content) do
    quote do
      @doc false
      def unquote(theme_name)() do
        unquote(Macro.escape(content))
      end
    end
  end
end
