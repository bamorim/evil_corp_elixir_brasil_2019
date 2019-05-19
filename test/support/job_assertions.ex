defmodule EvilCorp.JobAssertions do
  alias EvilCorp.Repo

  defmacro assert_has_job(args) do
    quote do
      Oban.Job
      |> EvilCorp.Repo.all()
      |> Enum.find(fn job ->
        match?(unquote(args), job.args)
      end)
      |> case do
        nil ->
          flunk("Could not find a matching Job")

        job ->
          job
      end
    end
  end

  defmacro refute_has_job(args) do
    quote do
      Oban.Job
      |> EvilCorp.Repo.all()
      |> Enum.find(fn job ->
        match?(unquote(args), job.args)
      end)
      |> case do
        nil ->
          nil

        job ->
          flunk("Found Job: #{inspect(job)}")
      end
    end
  end
end
