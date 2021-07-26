defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Schema.Account
  alias Rocketpay.Accounts.Transaction

  def render("update.json", %{
        account: %Account{
          id: account_id,
          balance: balance
        }
      }) do
    %{
      message: "Operation sucessful",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("transaction.json", %{
        transaction: %Transaction.DTO.Response{
          from: from_account,
          to: to_account
        }
      }) do
    %{
      message: "Transaction sucessful",
      from: from_account.id,
      to: to_account.id,
      current_balance: from_account.balance
    }
  end
end
