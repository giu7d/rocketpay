defmodule Rocketpay.Users.Create do
  alias Ecto.Multi
  alias Rocketpay.{Repo, Schema}

  def execute(params) do
    Multi.new()
    |> Multi.insert(:create_user, Schema.User.changeset(params))
    |> Multi.run(:create_account, fn repo, user -> insert_account(repo, user) end)
    |> Multi.run(:preload_data, fn repo, user -> preload_data(repo, user) end)
    |> run_transaction()
  end

  defp insert_account(repo, %{create_user: user}) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: 0.00}
    Schema.Account.changeset(params)
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, response, _changes} -> {:error, response}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end

  defp preload_data(repo, %{create_user: user}) do
    {:ok, repo.preload(user, :account)}
  end
end
