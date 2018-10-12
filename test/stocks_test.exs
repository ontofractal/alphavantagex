defmodule Alphavantagex.StocksTest do
  use ExUnit.Case
  import Alphavantagex.Stocks
  alias Alphavantagex.AdjOHLCV
  doctest Alphavantagex

  test "successfully fetches TSLA daily adjusted stock " do
    symbol = "TSLA"
    {:ok, %{body: body}} = fetch_ts_daily_adj(symbol)

    first = hd(body)

    assert %AdjOHLCV{
             adjusted_close: _,
             close: _,
             dividend_amount: _,
             high: _,
             low: _,
             open: _,
             split_coefficient: _,
             timestamp: _,
             datetime: _,
             volume: _
           } = first
  end
end
