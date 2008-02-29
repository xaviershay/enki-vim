#!/usr/bin/env ruby
require File.expand_path(File.join(File.dirname(__FILE__), 'common'))

# Parse buffer
buffer = VIM::Buffer.current

header = true
page = {'body' => []}

for index in (1..buffer.length)
  line = buffer[index]
  if header
    if line.length == 0
      header = false
    else
      tokens = line.split(': ')
      page[tokens.first] = tokens[1..-1].join(': ')
    end
  else
    page['body'] << line
  end
end


page['body'] = page['body'].join("\n")
id = page.delete('id')
    
post_data = {'page' => page}.to_yaml    
h = Net::HTTP.new('localhost', 3000)
resp, data = h.put("/admin/pages/#{id}.yaml", post_data, { 'X-EnkiHash' => hash_request(post_data), 'Content-Type' => 'application/x-yaml' })
puts resp.code
