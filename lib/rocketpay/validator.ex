defmodule Rocketpay.Validator do
  use Vex.Validator

  def validate(params, options \\ %{}) do
    case Vex.valid?(params, options) do
      true -> params
      false -> {:errors, Vex.errors(params, options)}
    end
  end
end
