# Price History of Any ASIN – Ruby example (stdlib only)
# Usage: ASIN_API_KEY=your-key ruby asin_history.rb
require "json"
require "net/http"
require "uri"

def call(method, url, body = nil)
  uri = URI(url)
  klass = { "GET" => Net::HTTP::Get, "POST" => Net::HTTP::Post, "PUT" => Net::HTTP::Put, "PATCH" => Net::HTTP::Patch, "DELETE" => Net::HTTP::Delete }[method]
  req = klass.new(uri)
  req["Authorization"] = "Bearer #{ENV.fetch("ASIN_API_KEY")}"
  if body
    req["Content-Type"] = "application/json"
    req.body = body
  end
  res = Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 120) { |http| http.request(req) }
  abort "HTTP #{res.code}: #{res.body}" unless res.is_a?(Net::HTTPSuccess)
  res.body
end

uri = URI("https://www.asin.dev/api/v1/history")
uri.query = URI.encode_www_form('asin' => 'B09DFCB66S', 'marketplace' => 'com', 'days' => '90')
response = call("GET", uri.to_s)

puts JSON.pretty_generate(JSON.parse(response))
