defmodule Faas do
  def run do
    Handler.run(System.argv())
  end
end
