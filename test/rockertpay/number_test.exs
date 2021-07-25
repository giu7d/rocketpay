defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "should return a valid value" do
      expected_response = {:ok, 55}

      "numbers"
      |> Numbers.sum_from_file()
      |> expect(expected_response)
    end

    test "should return a invalid value" do
      expected_response = {:error, "Invalid File Name!"}

      "wrong_name"
      |> Numbers.sum_from_file()
      |> expect(expected_response)
    end
  end

  defp expect(resulted, expected) do
    resulted == expected
  end
end
