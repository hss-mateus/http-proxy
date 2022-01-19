require "http/server"

host = ENV["HOST"]
tls = ENV.has_key?("TLS")
port = ENV["PORT"]?.try(&.to_i) || 3000
host_port =
  if tls
    ENV["HOST_PORT"]?.try(&.to_i) || 443
  else
    ENV["HOST_PORT"]?.try(&.to_i) || 80
  end

server = HTTP::Server.new do |context|
  method = context.request.method
  path = context.request.resource
  headers = context.request.headers
  body = context.request.body.try(&.gets_to_end)

  client = HTTP::Client.new(host, port: host_port, tls: tls)
  response = client.exec(method, path, headers: headers, body: body)
  client.close

  if response
    STDOUT << Time.utc << " " << method << " " << path << " " << response.status_code << "\n"

    context.response.headers.merge!(response.headers)
    context.response.status_code = response.status_code
    context.response.print(response.body)
  end
end

address = server.bind_tcp(port)
puts "Listening on http://#{address}"
server.listen
