defmodule FoodFavor.LogHelper do
  @moduledoc """
  Helper module for test assertions agains logging.
  """

  @spec assert_log(String.t() | Regex.t() | [String.t() | Regex.t()], any()) :: any()
  defmacro assert_log(messages, do_block) do
    messages = List.wrap(messages)

    quote do
      log =
        ExUnit.CaptureLog.capture_log(fn ->
          unquote(do_block)
        end)

      Enum.each(unquote(messages), fn msg ->
        assert log =~ msg
      end)
    end
  end

  @spec assert_not_logged(String.t() | Regex.t() | [String.t() | Regex.t()], any()) :: any()
  defmacro assert_not_logged(messages, do_block) do
    messages = List.wrap(messages)

    quote do
      log =
        ExUnit.CaptureLog.capture_log(fn ->
          unquote(do_block)
        end)

      Enum.each(unquote(messages), fn msg ->
        refute log =~ msg
      end)
    end
  end

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__), only: [assert_log: 2, assert_not_logged: 2]
    end
  end
end
