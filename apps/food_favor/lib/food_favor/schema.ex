defmodule FoodFavor.Schema do
  @moduledoc """
  Wrapper for Ecto.Schema to allow setting default options
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @timestamps_opts [type: :utc_datetime]
    end
  end
end
