defmodule RocketpayWeb.Router do
  use RocketpayWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RocketpayWeb do
    pipe_through :api

    post "/users", UsersController, :create
    post "/accounts/:id/deposit", AccountsController, :deposit
    post "/accounts/:id/withdraw", AccountsController, :withdraw
    post "/accounts/:id/transaction", AccountsController, :transaction
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RocketpayWeb.Telemetry
    end
  end
end
