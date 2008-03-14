#!/usr/bin/env ruby
[
  'enki_vim_config',
  'remote_enki_blog', 
  'vim_buffer'
].each do |file|
  require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', file))
end

buffer = VimBuffer.new
buffer.clear!

blog = RemoteEnkiBlog.new(EnkiVimConfig[:url], EnkiVimConfig[:key])
blog.posts.each do |post|
  buffer.append([post['id'], post['title']].join(" - "))
end
