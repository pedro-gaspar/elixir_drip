defmodule ElixirDrip.Storage.Workers.AgentCacheWorker do
  use Agent

  @expire_time 60_000

  alias ElixirDrip.Storage.Workers.CacheWorker

  def start_link(media_id, content) do
    Agent.start_link(
      fn ->
        IO.inspect(self(), label: "Inside agent")
        timer_process = spawn_link(&start_timer_process/0)
        timer = Process.send_after(timer_process, :expire, @expire_time)
        %{hits: 0, content: content, timer_process: timer_process, timer: timer}
      end,
      name: CacheWorker.name_for(media_id)
    )
  end

  defp start_timer_process() do
    IO.inspect(self(), label: "Inside timer process")

    receive do
      :expire ->
        IO.inspect(self(), label: "The end is near!!!")
        IO.puts("The end is near!!!")
        Process.exit(self(), :kill)
    end
  end

  def get_media(pid),
    do:
      Agent.get_and_update(pid, fn %{
                                     hits: hits,
                                     timer_process: timer_process,
                                     content: content,
                                     timer: timer
                                   } = state ->
        Process.cancel_timer(timer)
        timer = Process.send_after(timer_process, :expire, @expire_time)
        {content, %{state | hits: hits + 1, timer: timer}}
      end)
end
