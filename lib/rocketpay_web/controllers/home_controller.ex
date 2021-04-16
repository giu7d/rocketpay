defmodule RocketpayWeb.HomeController do
  use RocketpayWeb, :controller

  def index(conn, %{"filename" => filename}) do
    filename
    |> Rocketpay.Numbers.sum_from_file()
    |> handle_response(conn)
  end

  defp handle_response({:ok, result}, conn)  do
    conn
    |> put_status(:ok)
    |> json(%{message: "Your result is #{result}"})
  end

  defp handle_response({:error, reason}, conn)  do
    conn
    |> put_status(:bad_request)
    |> json(%{message: "Bad Request! #{reason}"})
  end
end
