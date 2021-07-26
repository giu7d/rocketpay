defmodule Rocketpay.Accounts.Operation do
  alias Ecto.Multi
  alias Rocketpay.Schema

  def execute(%{"id" => id, "value" => value}, operation) do
    account_operation = account_operation_name(operation)

    Multi.new()
    |> Multi.run(account_operation, fn repo, _changes ->
      get_account(repo, id)
    end)
    |> Multi.run(operation, fn repo, changes ->
      update_balance(repo, Map.get(changes, account_operation), value, operation)
    end)
  end

  defp get_account(repo, id) do
    case repo.get(Schema.Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value, operation) do
    account
    |> account_operation(value, operation)
    |> update_account(repo, account)
  end

  defp account_operation(%Schema.Account{balance: balance}, value, operation) do
    value
    |> Decimal.cast()
    |> handle_cast(balance, operation)
  end

  defp handle_cast({:ok, value}, balance, :deposit), do: Decimal.add(balance, value)
  defp handle_cast({:ok, value}, balance, :withdraw), do: Decimal.sub(balance, value)
  defp handle_cast(:error, _balance, :deposit), do: {:error, "Invalid deposit value!"}
  defp handle_cast(:error, _balance, :withdraw), do: {:error, "Invalid withdraw value!"}

  defp update_account({:error, _result} = error, _repo, _account), do: error

  defp update_account(value, repo, account) do
    params = %{balance: value}

    account
    |> Schema.Account.changeset(params)
    |> repo.update()
  end

  defp account_operation_name(operation) do
    "account#{Atom.to_string(operation)}" |> String.to_atom()
  end
end
