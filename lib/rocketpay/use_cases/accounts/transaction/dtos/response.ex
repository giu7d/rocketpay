defmodule Rocketpay.Accounts.Transaction.DTO.Response do
  alias Rocketpay.Schema.Account

  defstruct [:from, :to]

  def new(%Account{} = from, %Account{} = to) do
    %__MODULE__{
      from: from,
      to: to
    }
  end
end
