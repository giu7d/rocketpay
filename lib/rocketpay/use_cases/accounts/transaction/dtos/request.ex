defmodule Rocketpay.Accounts.Transaction.DTO.Request do
  defstruct [:id, :to, :value]

  def adapt(json) do
    json
    |> Utils.from_keyword_to_atom()
    |> generate()
  end

  def generate(%{id: id, to: to, value: value}) do
    %__MODULE__{
      id: id,
      to: to,
      value: value
    }
  end
end
