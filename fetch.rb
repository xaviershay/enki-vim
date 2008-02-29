#!/usr/bin/env ruby
require File.expand_path(File.join(File.dirname(__FILE__), 'common'))

h = Net::HTTP.new('localhost', 3000)
  buffer = VIM::Buffer.current
id = buffer.line
resp, data = h.get("/admin/pages/#{id}.yaml", { 'X-EnkiHash' => hash_request(''), 'Content-Type' => 'application/x-yaml' })

if resp.code == "200"
  # Clear buffer
  while (buffer.length > 1)
    buffer.delete(1)
  end
  buffer.delete(1)

  params = YAML.load(data)['page']
  buffer.append(buffer.length - 1, "id: #{id}")
  buffer.append(buffer.length - 1, "title: " + params['title'])
  buffer.append(buffer.length - 1, "slug: " + params['slug'])
  buffer.append(buffer.length - 1, "created_at: " + params['created_at'].iso8601)
  buffer.append(buffer.length - 1, "updated_at: " + params['updated_at'].iso8601)
  buffer.append(buffer.length - 1, "")

  params['body'].each_line do |line|
    buffer.append(buffer.length-1, line.chomp)
  end

  buffer.delete(buffer.length)
end
