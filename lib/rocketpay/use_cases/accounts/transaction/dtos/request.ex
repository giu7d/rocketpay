defmodule Rocketpay.Accounts.Transaction.DTO.Request do
  use Vex.Struct

  defstruct [:id, :to, :value]

  validates(:id,
    uuid: true,
    presence: true
  )

  validates(:to,
    uuid: true,
    presence: true
  )

  validates(:value,
    number: true,
    presence: true
  )

  def new(%{"id" => id, "to" => to, "value" => value}) do
    %__MODULE__{
      id: id,
      to: to,
      value: value
    }
  end
end
