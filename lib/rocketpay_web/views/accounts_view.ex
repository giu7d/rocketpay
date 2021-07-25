defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Schema.Account

  def render("create.json", %{
        account: %Account{
          id: account_id,
          balance: balance
        }
      }) do
    %{
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end
end
