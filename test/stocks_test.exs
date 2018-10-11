defmodule Alphavantagex.StocksTest do
  use ExUnit.Case
  import Alphavantagex.Stocks
  doctest Alphavantagex

  test "successfully fetches TSLA daily adjusted stock " do
    symbol = "TSLA"
    {:ok, %{body: body}} = fetch_ts_daily_adj(symbol)

    assert %{
             "adjusted_close" => _,
             "close" => _,
             "dividend_amount" => _,
             "high" => _,
             "low" => _,
             "open" => _,
             "split_coefficient" => _,
             "timestamp" => _,
             "volume" => _
           } = hd(body)
  end
end
