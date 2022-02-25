defmodule LiveUiKit.Theme.Tailwind do
  @moduledoc false

  import YamlElixir.Sigil

  def theme do
    ~y"""
    alert:
      base: "rounded-lg py-5 px-6 mb-4 text-base mb-3 flex items-center"
      info: "bg-blue-100 text-blue-700"
      success: "bg-green-100 text-green-700"
      warning: "bg-yellow-200 text-yellow-800"
      error:

    badge:
      base: "text-xs inline-block py-1 px-2.5 leading-none text-center whitespace-nowrap align-baseline font-bold rounded"
      primary: "bg-blue-600 text-white"
      secondary:
      info:
      success:
      warning:
      error:
      alt:
        primary:
        secondary:
        info:
        success:
        warning:
        error:

    button:
      primary:
      secondary:
      info:
      success:
      warning:
      error:
      link:

    button:
      base: "dsfdsfsd"
      variants:
        primary:
        secondary:
        info:
        success:
        warning:
        error:
        link:

    card:
      base: "block rounded-lg shadow-lg bg-white border"

    card_body:
      base: "p-6"

    card_header:
      base: "py-3 px-6 border-b border-gray-300"

    card_title:
      base: "text-gray-900 text-xl leading-tight font-medium mb-2"

    card_subtitle:
      base: ""

    card_footer:
      base: "py-3 px-6 border-t border-gray-300 text-gray-600"

    card_link:
      base:

    collapse:
      base: "overflow-hidden max-h-0 duration-500 transition-all"

    dropdown:
      base: "relative inline-block text-left"
    dropdown_toggle:
      base: "flex items-center"
    dropdown_menu:
      base: "border shadow-xl menu bg-base-100 border-base-200 rounded-box w-52"
    dropdown_item:
      base:
    dropdown_divider:
      base:


    modal:
      base: "fixed top-0 left-0 z-50 w-full h-screen outline-none"

    modal_dialog:
      base: "w-full h-full overflow-x-scroll"

    modal_backdrop:
      base: "absolute inset-0 z-40 bg-gray-900 opacity-75"

    modal_content:
      base: "relative z-50 w-auto max-w-lg px-4 mx-auto my-8 shadow-lg poiner-events-none sm:px-0"

    modal_header:
      base: "flex items-start justify-between p-4 border-b rounded-t border-base-200"

    modal_title:
      base: "mb-0 text-lg leading-normal"

    modal_body:
      base: "relative flex-auto p-4"

    modal_footer:
      base:
    """
  end
end
