defmodule Alphavantagex.Stocks do
  alias NimbleCSV.RFC4180, as: NimbleCSV

  use Tesla, docs: false, only: ~w(get)a

  def fetch_ts_daily_adj(symbol) do
    client = Alphavantagex.client()

    result =
      get(client, "/",
        query: [function: "TIME_SERIES_DAILY_ADJUSTED", symbol: symbol, datatype: "csv"]
      )

    with {:ok, tesla_env} <- result do
      body = parse_csv(tesla_env.body)

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
