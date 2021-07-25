defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Schema.{Account}

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit_account(params) do
      conn
      |> put_status(:created)
      |> render("create.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw_account(params) do
      conn
      |> put_status(:created)
      |> render("create.json", account: account)
    end
  end
end
