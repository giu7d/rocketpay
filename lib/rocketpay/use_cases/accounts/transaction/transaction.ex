defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi
  alias Rocketpay.{Accounts, Repo}
  alias Rocketpay.Accounts.Transaction.DTO

  def execute(%DTO.Request{} = data) do
    Multi.new()
    |> Multi.merge(fn _changes ->
      Accounts.Operation.execute(build_params(data.id, data.value), :withdraw)
    end)
    |> Multi.merge(fn _changes ->
      Accounts.Operation.execute(build_params(data.to, data.value), :deposit)
    end)
    |> commit_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp commit_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _, response, _} ->
        {:error, response}

      {:ok, %{withdraw: from_account, deposit: to_account}} ->
        {:ok, DTO.Response.new(from_account, to_account)}
    end
  end
end
