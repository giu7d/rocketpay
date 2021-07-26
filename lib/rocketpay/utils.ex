defmodule Utils do
  def from_keyword_to_atom(keyword_list) do
    for {key, val} <- keyword_list, into: %{} do
      {String.to_existing_atom(key), val}
    end
  end
end
