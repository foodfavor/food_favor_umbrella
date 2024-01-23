defmodule FoodFavor.LogTest do
  use FoodFavor.DataCase, async: true

  alias FoodFavor.Error
  alias FoodFavor.Log

  describe "report/2" do
    test "accepts an info log with FoodFavor.Error" do
      # With config/test.exs `:logger, level: :warning`, :info logs are not broadcast to be asserted
      error = {:error, %Error{type: :general_error, message: "test warning log message"}}
      assert :ok == Log.report(error, :info)
    end

    test "will log warning with FoodFavor.Error" do
      assert_log "test warning log message" do
        error = {:error, %Error{type: :general_error, message: "test warning log message"}}
        assert :ok == Log.report(error, :warning)
      end
    end

    test "will log error with FoodFavor.Error" do
      assert_log "test error log message" do
        error = {:error, %Error{type: :general_error, message: "test error log message"}}
        assert :ok == Log.report(error, :error)
      end
    end

    test "will log warning with Ecto.Changeset" do
      assert_log ~r/Changeset *. error/ do
        error = {:error, create_changeset_error()}
        assert :ok == Log.report(error, :warning)
      end
    end

    test "will log error with Ecto.Changeset" do
      assert_log ~r/Changeset *. error/ do
        error = {:error, create_changeset_error()}
        assert :ok == Log.report(error, :error)
      end
    end

    defp create_changeset_error do
      cast({%{}, %{age: :integer}}, %{age: "invalid"}, [:age])
    end
  end
end
