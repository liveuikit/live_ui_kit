defmodule Mix.Tasks.LiveUiKit.Gen.Config do
  @shortdoc "Generates a config file that contains the component classes"

  @moduledoc """
  Generates a config file that contains the component classes. For example:

      mix saas_ui_kit.gen.config --bootstrap

  Possible arguments are tailwind or bootstrap. If no argument is provided,
  it will fallback to bootstrap. The idea that the generated class names are
  a starting point and can be customized for your project.
  """
  use Mix.Task

  @possible_frameworks ~w(bootstrap tailwind daisyui)

  @doc false
  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise "mix saas_ui_kit.gen.config can only be run inside an application directory"
    end

    framework = Enum.find(@possible_frameworks, fn framework ->
      Enum.find(args, fn arg -> String.contains?(arg, framework) end)
    end) || "tailwind"

    otp_app = Application.get_env(:live_ui_kit, :otp_app)

    if !otp_app do
      Mix.raise """
      You must set the otp_app in config.exs

      config :live_ui_kit,
        theme: :#{framework},
        otp_app: :my_app
      """
    end

    module_name = Macro.camelize("#{otp_app}")

    bindings = [
      module_name: module_name,
      theme_map: LiveUiKit.get_base_css_from_teme(framework)
    ]

    copy_from("priv/templates", bindings, [
      {"tailwind.eex", "lib/#{otp_app}_web/live_ui_kit_config.ex"}
    ])

    Mix.shell().info """

    Module generated. You must set the module in config.exs

    config :live_ui_kit,
      theme: :#{framework},
      otp_app: :#{otp_app},
      config: #{module_name}Web.LiveUiKitConfig
    """
  end

  defp copy_from(source_dir, bindings, mapping) when is_list(bindings) and is_list(mapping) do
    for {source_file_path, target_file_path} <- mapping do
      contents =
        [Application.app_dir(:live_ui_kit), source_dir, source_file_path]
        |> Path.join()
        |> File.read!()
        |> EEx.eval_string(assigns: bindings)

      Mix.Generator.create_file(target_file_path, contents)
      Mix.Tasks.Format.run([target_file_path])
    end
  end
end
