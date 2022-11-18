defmodule Pushover do
  alias Pushover.AuthenticationError

  @missing_config_error_message """
  To authenticated with Pushover you need to provide valid a user string and 
  an application token. Please include them in your application config file
  like so:

    config :pushover,
      user: "YOUR_USER"
      token: "YOUR_TOKEN",

  """

  def get_user do
    System.get_env("PUSHOVER_USER") ||
      Application.get_env(:pushover, :user) ||
      Application.get_env(:pushover, :group) ||
      raise AuthenticationError, message: @missing_config_error_message
  end

  def get_team do
    System.get_env("PUSHOVER_TEAM") ||
      Application.get_env(:pushover, :team) ||
      raise AuthenticationError, message: @missing_config_error_message
  end

  def get_token do
    System.get_env("PUSHOVER_TOKEN") ||
      Application.get_env(:pushover, :token) ||
      raise AuthenticationError, message: @missing_config_error_message
  end
end
