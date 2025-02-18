defmodule BellWeb.FormController do
  use BellWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def submit(conn, %{"form" => form_params}) do
    IO.inspect(form_params)
    redirect(conn, to: "/")
  end
end
