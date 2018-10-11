defmodule Alphavantagex do
  @moduledoc """
  Documentation for Alphavantagex.
  """
  @url "https://www.alphavantage.co/query"

  @doc """
  Build an Alphavantex client
  """
  @spec client(list(), list()) :: Tesla.Env.client()
  def client(pre \\ [], post \\ []) do
    api_key = Application.get_env(:alphavantagex, :api_key)
    Tesla.build_client(
      [
        {Tesla.Middleware.BaseUrl, @url},
        {Tesla.Middleware.Query, [apikey: api_key]}
      ] ++ pre,
      [{Tesla.Middleware.JSON, []}] ++ post
    )
  end
end
