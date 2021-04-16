defmodule Rocketpay.Users.Create do
  alias Rocketpay.{Repo, User}

  def execute(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
