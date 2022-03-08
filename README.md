# LiveUiKit

<!-- MDOC !-->

[![Module Version](https://img.shields.io/hexpm/v/bootstrap_icons.svg)](https://hex.pm/packages/live_ui_kit/)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/live_ui_kit/)
[![Total Download](https://img.shields.io/hexpm/dt/live_ui_kit.svg)](https://hex.pm/packages/live_ui_kit)
[![License](https://img.shields.io/hexpm/l/live_ui_kit.svg)](https://github.com/liveuikit/live_ui_kit/blob/master/LICENSE.txt)
[![Last Updated](https://img.shields.io/github/last-commit/liveuikit/live_ui_kit.svg)](https://github.com/liveuikit/live_ui_kit/commits/master)


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `live_ui_kit` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:live_ui_kit, "~> 0.1.4"}
  ]
end
```
Pick one of the available themes. `:tailwind`, `:daisyui` or `:bootstrap`

```elixir
config :live_ui_kit,
  theme: :tailwind,
  otp_app: :my_app
```

Include the library in one of two ways. Either in a specific LiveView file:

```elixir
defmodule ExampleAppWeb.PageLive do
  use ExampleAppWeb, :live_view
  use LiveUiKit

  # Other code
end
```

Or add this to the web module if you want to access it from all LiveView pages:

```elixir
# app/example_app_web.ex
defmodule ExampleAppWeb do
  # Other code

  defp view_helpers do
    quote do
      use Phoenix.HTML
      import Phoenix.LiveView.Helpers
      import Phoenix.View
      import ExampleAppWeb.ErrorHelpers
      import ExampleAppWeb.Gettext
      alias ExampleAppWeb.Router.Helpers, as: Routes

      # ADD THIS
      use LiveUiKit
    end
  end
end
```
If you use Tailwind and use the purge option, add this line in the tailwind.config.js:

```js
module.exports = {
  mode: 'jit',
  content: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex',
    '../deps/live_ui_kit/**/*.yml' // Add this
  ],
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
```

Add the optional animation classes to the css file:

```css
/* animations */
.modal-content-in {
  animation: 0.2s ease-in 0s normal forwards 1 modal-content-in-keys;
}

.modal-content-out {
  animation: 0.2s ease-out 0s normal forwards 1 modal-content-out-keys;
}

.fade-in-scale {
  animation: 0.2s ease-in 0s normal forwards 1 fade-in-scale-keys;
}

.fade-out-scale {
  animation: 0.2s ease-out 0s normal forwards 1 fade-out-scale-keys;
}

.fade-in {
  animation: 0.2s ease-in 0s normal forwards 1 fade-in-keys;
}
.fade-out {
  animation: 0.2s ease-out 0s normal forwards 1 fade-out-keys;
}

@keyframes modal-content-in-keys{
  0% { opacity: 0; margin-top: 0.6rem; }
  100% { opacity: 1; margin-top: 2rem; }
}

@keyframes modal-content-out-keys{
  0% { opacity: 1; margin-top: 2rem; }
  100% { opacity: 0; margin-top: 0.6rem; }
}

@keyframes fade-in-scale-keys{
  0% { scale: 0.95; opacity: 0; }
  100% { scale: 1.0; opacity: 1; }
}

@keyframes fade-out-scale-keys{
  0% { scale: 1.0; opacity: 1; }
  100% { scale: 0.95; opacity: 0; }
}

@keyframes fade-in-keys{
  0% { opacity: 0; }
  100% { opacity: 1; }
}

@keyframes fade-out-keys{
  0% { opacity: 1; }
  100% { opacity: 0; }
}
```

