defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_sum()
    |> handle_response()
  end


  defp handle_sum({:ok, data}) do
    data
    |> String.split(",")
    |> Stream.map(fn number -> String.to_integer(number) end)
    |> Enum.sum()
  end
  defp handle_sum(data), do: data

  defp handle_response({:error, :enoent}), do: {:error, "Invalid File Name!"}
  defp handle_response({:error, _message}), do: {:error, "Unexpected Error!"}
  defp handle_response(result), do: {:ok, result}

end
