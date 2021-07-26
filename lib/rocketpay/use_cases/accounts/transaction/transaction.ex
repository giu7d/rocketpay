defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi
  alias Rocketpay.{Accounts, Repo}
  alias Rocketpay.Accounts.Transaction.DTO

  def execute(%DTO.Request{
        id: from_id,
        to: to_id,
        value: value
      }) do
    Multi.new()
    |> Multi.merge(fn _changes ->
      Accounts.Operation.execute(build_params(from_id, value), :withdraw)
    end)
    |> Multi.merge(fn _changes ->
      Accounts.Operation.execute(build_params(to_id, value), :deposit)
    end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _, response, _} ->
        {:error, response}

      {:ok, %{withdraw: from_account, deposit: to_account}} ->
        {:ok, DTO.Response.generate(from_account, to_account)}
    end
  end
end
