defmodule WebsocketsTermimal.Channels.Shell do
  use Phoenix.Channel

  def join("shell", _message, socket) do
    IO.puts "JOIN #{socket.channel}.#{socket.topic}"
    reply socket, "join", %{status: "connected"}
    {:ok, socket}
  end

  def join(_priv_topic, _message, socket) do
    {:error, socket, :unauthorized}
  end

  def handle_in("shell:stdin", message, socket) do
    WebsocketsTermimal.ShellServer.eval(:shell, message["data"], socket)
    {:ok, socket}
  end

  def handle_out(event, message, socket) do
    reply socket, event, message
    {:ok, socket}
  end

  def leave(_reason, socket) do
    {:ok, socket}
  end
end
