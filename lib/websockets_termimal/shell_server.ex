defmodule WebsocketsTermimal.ShellServer do
  alias Porcelain.Process, as: Proc
  use Phoenix.Channel

  def start_link(opts \\ []) do
    GenServer.start_link __MODULE__, :ok, opts
  end

  def eval(server, command, socket) do
    GenServer.cast server, {:eval, command, socket}
  end

  ### GenServer callback
  def init(:ok) do
    proc = Porcelain.spawn_shell(
              "bash",
              in: :receive, out: {:send, self()}
          )
    {:ok, {proc, nil}}
  end

  def handle_cast({:eval, command, socket}, {proc, _}) do
    Proc.send_input proc, "#{command}\n"
    {:noreply, {proc, socket}}
  end

  def handle_info({_, :data, :out, data}, {proc, socket}) do
    IO.inspect data
    broadcast socket, "stdout", %{data: Base.encode64(data)}
    {:noreply, {proc, socket}}
  end

  def handle_info(noclue, state) do
    IO.puts "unhandled info"
    IO.inspect noclue
    {:noreply, state}
  end
end
