defmodule KinoLink.LinkCell do
  @moduledoc false

  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Link"

  @impl true
  def init(attrs, ctx) do
    source = attrs["source"] || ""
    {:ok, assign(ctx, source: source), editor: [source: source]}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{}, ctx}
  end

  @impl true
  def handle_editor_change(source, ctx) do
    {:ok, assign(ctx, source: source)}
  end

  @impl true
  def to_attrs(ctx) do
    %{"source" => ctx.assigns.source}
  end

  @impl true
  def to_source(attrs) do
    quote do
      KinoLink.new(unquote(attrs["source"]))
    end
    |> Kino.SmartCell.quoted_to_string()
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
      ctx.importCSS("main.css");
      ctx.root.innerHTML = `
        <div class="link-cell">Please enter the URL below.</di>
      `;
    }
    """
  end

  asset "main.css" do
    """
    .link-cell {
      padding: 0.5rem 1rem;
      background-color: #ecf0ff;
      border: solid 1px #cad5e0;
      border-radius: 0.5rem 0.5rem 0 0;
    }
    """
  end
end
