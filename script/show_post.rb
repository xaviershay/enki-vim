#!/usr/bin/env ruby
[
  'enki_vim_config',
  'remote_enki_blog', 
  'vim_buffer',
  'tag_list'
].each do |file|
  require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', file))
end

buffer = VimBuffer.new
buffer.clear!

blog = RemoteEnkiBlog.new(EnkiVimConfig[:url], EnkiVimConfig[:key])
id = 2 #buffer.current_line.to_i
post = blog.post(id)

buffer.append("id: #{id}")
buffer.append("title: " + post['title'])
buffer.append("slug: " + post['slug'])
buffer.append("created_at: " + post['created_at'].iso8601)
buffer.append("updated_at: " + post['updated_at'].iso8601)
buffer.append("")
buffer.append(post['body'])
