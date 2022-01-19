# http-proxy

A simple HTTP forward proxy server

## Installation

Download the latest release and put in your $PATH

## Usage

Configure the server by changing the following environment variables:

- `HOST`: Target host domain or IP
- `HOST_PORT`: Destination port (defaults to 80 or 443 if `TLS` is set)
- `TLS`: Use TLS to communicate to the target server. Set to null to disable
- `PORT`: Port to run the proxy server (defaults to 3000)

## Development

With [crystal](https://crystal-lang.org/) and
[shards](https://github.com/crystal-lang/shards) installed, you can build the
project by running `shards build`.
