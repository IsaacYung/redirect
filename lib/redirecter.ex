defmodule Redirecter do
  @moduledoc """
    Ex: Redirecter.read_file "/home/(seu_user)/Desktop/erros.csv"
  """

  def read_file(file) do
    error_list = CSVLixir.read(file)

    IO.puts " ***Compare results\n\n"
    Enum.each(error_list, fn(s) ->
      [url, response_status, notice_error, detected, category, plataform, last_crawl] = s

      if url != "URL" do
        response = HTTPotion.get(URI.encode(url))

        cond do
          response.status_code == 200 ->
          [
            :color46, " #{url}\n",
            :color49, " CSV status: ",
            :color196, "#{response_status}",
            :color49, " Response status: ",
            :color46, "#{response.status_code}\n"
          ]
          |> Bunt.puts

          to_string(response.status_code) == response_status ->
          [
            :color196, " #{url}\n",
            :color49, " CSV status: ",
            :color196, "#{response_status}",
            :color49, " Response status: ",
            :color196, "#{response.status_code}\n"
          ]
          |> Bunt.puts

          true ->
          [
            :orange, " #{url}\n",
            :color49, " CSV status: ",
            :orange, "#{response_status}",
            :color49, " Response status: ",
            :orange, "#{response.status_code}\n"
          ]
          |> Bunt.puts
        end
      end
    end)
  end
end
