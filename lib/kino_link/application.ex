defmodule KinoLink.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Kino.SmartCell.register(KinoLink.LinkCell)

    children = []
    opts = [strategy: :one_for_one, name: KinoLink.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
