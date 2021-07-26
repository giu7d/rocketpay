defmodule Rocketpay do
  alias Rocketpay.{Accounts, Users}

  defdelegate create_user(params), to: Users.Create, as: :execute
  defdelegate deposit_account(params), to: Accounts.Deposit, as: :execute
  defdelegate withdraw_account(params), to: Accounts.Withdraw, as: :execute
  defdelegate transaction_account(params), to: Accounts.Transaction, as: :execute
end
