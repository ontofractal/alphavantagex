defmodule Alphavantagex.AdjOHLHCV do
  use Construct do
    field :adjusted_close, :float
    field :close, :float
    field :dividend_amount, :float
    field :high, :float
    field :low, :float
    field :open, :float
    field :split_coefficient, :float
    field :timestamp, :integer
    field :volume, :float
  end

  def parse!(raw) do
    raw
    |> Map.update!(:timestamp, &datestring_to_timestamp/1)
  end

  def datestring_to_timestamp(str) do
    str
    |> Date.from_iso8601!()
    |> Timex.to_unix()
  end
end
