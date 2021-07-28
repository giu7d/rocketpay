defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Schema.Account
  alias Rocketpay.Accounts.Transaction.DTO.Request, as: TransactionRequest
  alias Rocketpay.Accounts.Transaction.DTO.Response, as: TransactionResponse
  alias Rocketpay.Validator

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit_account(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw_account(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %TransactionResponse{} = transaction} <-
           params
           |> TransactionRequest.new()
           |> Validator.validate()
           |> Rocketpay.transaction_account() do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
