defmodule Alphavantagex.Stocks do

  use Tesla, docs: false, only: ~w(get)a

  def fetch_ts_daily_adj(symbol) do
    client = Alphavantagex.client()

    result =
      get(client, "/",
        query: [function: "TIME_SERIES_DAILY_ADJUSTED", symbol: symbol, datatype: "csv"]
      )

    with {:ok, tesla_env} <- result do

      {:ok, tesla_env}
    end
  end

end
