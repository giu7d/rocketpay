defmodule Rocketpay.Accounts.Transaction.DTO.Response do
  alias Rocketpay.Schema.Account

  defstruct from: nil, to: nil

  def generate(%Account{} = from, %Account{} = to) do
    %__MODULE__{
      from: from,
      to: to
    }
  end
end
