defmodule KinoLink do
  @moduledoc """
  A simple Kino for display Link files on Livebook.
  """
  use Kino.JS

  def new(url) do
    link =
      case OpenGraph.fetch(url) do
        {:ok, %OpenGraph{title: title, image: image_url}} ->
          title =
            if is_nil(title) do
              get_title(url)
            else
              title
            end

          root_url = get_root_url(url)
          image_tag = image_tag(image_url, title)

          """
          <a href="#{url}" target="_blank">
            <div class="kino-link">
              <div class="kino-link__content">
                <h3 class="kino-link__title">#{title}</h3>
                <p class="kino-link__url">#{root_url}</p>
              </div>
              #{image_tag}
            </div>
          </a>
          """

        _ ->
          """
          <a href="#{url}" target="_blank">#{url}</a>
          """
      end

    Kino.JS.new(__MODULE__, link)
  end

  defp get_title(url) do
    url
    |> Req.get!()
    |> Map.get(:body)
    |> Floki.parse_document!()
    |> Floki.find("title")
    |> Floki.text()
  end

  defp get_root_url(url) do
    url
    |> URI.parse()
    |> then(fn uri -> "#{uri.scheme}://#{uri.host}" end)
  end

  defp image_tag(nil, _), do: ""

  defp image_tag(image_url, title) do
    """
    <div class="kino-link__image">
      <img src="#{image_url}" alt="#{title}" />
    </div>
    """
  end

  asset "main.js" do
    """
    export function init(ctx, iframe) {
      ctx.importCSS("main.css");
      ctx.root.innerHTML = iframe;
    }
    """
  end

  asset "main.css" do
    """
    a:has(.kino-link) {
      color: inherit;
      text-decoration: none;
    }

    .kino-link {
      display: flex;
      align-items: center;
      justify-content: space-between;
      border: 1px solid #ccc;
      border-radius: 0.5rem;
      margin: 0 0 0.5rem 0;
      word-break: break-all;
    }

    .kino-link__image {
      width: auto;
      height: 136px;
      overflow: hidden;
      border-left: 1px solid #ccc;
      border-radius: 0 0.5rem 0.5rem 0;
    }

    .kino-link__image img {
      width: auto;
      height: 100%;
      object-fit: cover;
    }

    .kino-link__content {
      flex: 1;
      padding: 0.5rem 1rem;
    }

    .kino-link__title {
      margin: 0 0 0.5rem 0;
      font-size: 1.25rem;
    }

    .kino-link__url {
      margin: 0;
      font-size: 1rem;
    }
    """
  end
end
