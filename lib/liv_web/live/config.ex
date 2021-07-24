defmodule LivWeb.Config do
  use Surface.Component

  alias LivWeb.Router.Helpers, as: Routes
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, TextInput, NumberInput, Label, TextArea}
  alias Surface.Components.LivePatch

  prop change, :event, required: true
  prop my_addr, :list, required: true
  prop my_addrs, :list, required: true
  prop my_lists, :list, required: true
  prop days, :integer, required: true
  prop maildir, :string, required: true
  prop orbit_api_key, :string, required: true
  prop orbit_workspace, :string, required: true
end
