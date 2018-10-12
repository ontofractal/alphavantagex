defmodule Alphavantagex.Stocks do
  alias NimbleCSV.RFC4180, as: NimbleCSV
  alias Alphavantagex.AdjOHLCV

  use Tesla, docs: false, only: ~w(get)a

  @doc """
  Fetches adjusted daily timeseries for give symbol

  Arguments:

  - symbol: "AAPL", "TSLA" or other stock symbol
  - options: [output_size: "full" | "compact"] use compact to limit result length to 100 items

  Response Body is a list of %AdjOHLHCV{} structs

  ```
  %AdjOHLHCV{
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
   }
  ```
  """
  def fetch_ts_daily_adj(symbol, options \\ []) do
    client = Alphavantagex.client()

    result =
      get(client, "/",
        query: [
          function: "TIME_SERIES_DAILY_ADJUSTED",
          symbol: symbol,
          datatype: "csv",
          outputsize: options[:output_size] || "full"
        ]
      )

    with {:ok, tesla_env} <- result do
      body =
        tesla_env.body
        |> parse_csv()
        |> Enum.map(&MapKeys.to_atoms_unsafe!/1)
        |> Enum.map(&AdjOHLCV.parse!/1)
        |> Enum.map(&AdjOHLCV.make!/1)

      tesla_env = Map.put(tesla_env, :body, body)
      {:ok, tesla_env}
    end
  end

  def parse_csv(string) do
    string
    |> NimbleCSV.parse_string(headers: false)
    |> Stream.map(&Enum.join(&1, ","))
    |> CSV.decode!(headers: true)
    |> Enum.to_list()
  end
end
