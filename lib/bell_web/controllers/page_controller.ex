defmodule BellWeb.PageController do
  use BellWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # form_controller
    render(conn, :home, layout: false)
  end
end
