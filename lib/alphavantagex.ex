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
    Tesla.build_client(
      [{Tesla.Middleware.BaseUrl, @url}] ++ pre,
      [{Tesla.Middleware.JSON, []}] ++ post
    )
  end
end
