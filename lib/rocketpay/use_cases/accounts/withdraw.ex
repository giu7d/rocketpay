defmodule Rocketpay.Accounts.Withdraw do
  alias Rocketpay.{Accounts, Repo}

  def execute(params) do
    params
    |> Accounts.Operation.execute(:withdraw)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _, response, _} -> {:error, response}
      {:ok, %{withdraw: account}} -> {:ok, account}
    end
  end
end
