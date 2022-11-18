defmodule Pushover.Api.Messages do
  @moduledoc """
  API calls for Pushover Message API
  """

  alias Pushover.Connection
  alias GoogleApi.Gax.{Request, Response}

  @doc """
  Sends a message.

  ## Parameters

  *   `message` (*type:* `Pushover.Model.Message`) - the message to send.
  *   `connection` (*type:* `Pushover.Connection.t`) - Connection to server

  ## Returns
  *   `{:ok, %{}}` on success
  *   `{:error, info}` on failure
  """

  @spec send(Pushover.Model.Message.t(), Pushover.Connection.t()) ::
          {:ok, Pushover.Model.MessageResponse.t()} | {:error, Tesla.Env.t()}
  def send(message, connection \\ Connection.new())

  def send(%Pushover.Model.Message{user: user_key} = message, connection) do
    optional_params_config = %{
      :device => :query,
      :title => :body,
      :url => :query,
      :url_title => :query,
      :priority => :query,
      :retry => :query,
      :expire => :query,
      :sound => :query,
      :timestamp => :query
    }

    keys =
      Enum.filter(Map.keys(message), fn x -> Enum.member?(Map.keys(optional_params_config), x) end)

    optional_params = Keyword.new(keys, fn x -> {x, Map.fetch!(message, x)} end)

    request =
      Request.new()
      |> Request.method(:post)
      |> Request.url("/messages.json")
      |> Request.add_param(:query, :token, Pushover.get_token())
      |> Request.add_param(:query, :user, user_key)
      |> Request.add_param(:body, :message, message.data)
      |> Request.add_optional_params(optional_params_config, optional_params)

    connection
    |> Connection.execute(request)
    |> Response.decode(struct: %Pushover.Model.MessageResponse{})
  end

  def send(message, connection) do
    optional_params_config = %{
      :device => :query,
      :title => :body,
      :url => :query,
      :url_title => :query,
      :priority => :query,
      :retry => :query,
      :expire => :query,
      :sound => :query,
      :timestamp => :query
    }

    keys =
      Enum.filter(Map.keys(message), fn x -> Enum.member?(Map.keys(optional_params_config), x) end)

    optional_params = Keyword.new(keys, fn x -> {x, Map.fetch!(message, x)} end)

    request =
      Request.new()
      |> Request.method(:post)
      |> Request.url("/messages.json")
      |> Request.add_param(:query, :token, Pushover.get_token())
      |> Request.add_param(:query, :user, Pushover.get_group_or_user())
      |> Request.add_param(:body, :message, message.data)
      |> Request.add_optional_params(optional_params_config, optional_params)

    connection
    |> Connection.execute(request)
    |> Response.decode(struct: %Pushover.Model.MessageResponse{})
  end
end
