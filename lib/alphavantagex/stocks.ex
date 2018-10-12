defmodule Alphavantagex.Stocks do
  alias NimbleCSV.RFC4180, as: NimbleCSV

  use Tesla, docs: false, only: ~w(get)a

  @doc """
  Response Body is a list of maps with the following shape

  %{
     adjusted_close: _,
     close: _,
     dividend_amount: _,
     high: _,
     low: _,
     open: _,
     split_coefficient: _,
     timestamp: _,
     volume: _
   }
  """
  def fetch_ts_daily_adj(symbol) do
    client = Alphavantagex.client()

    result =
      get(client, "/",
        query: [function: "TIME_SERIES_DAILY_ADJUSTED", symbol: symbol, datatype: "csv"]
      )

    with {:ok, tesla_env} <- result do
      body =
        tesla_env.body
        |> parse_csv()
        |> Enum.map(&MapKeys.to_atoms_unsafe!/1)

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
