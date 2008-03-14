require 'net/http'
require 'digest/sha1'
require 'yaml'
require 'time'

class RemoteEnkiBlog
  attr_accessor :url
  attr_accessor :key

  def initialize(url, key)
    self.url = url
    self.key = key
    url = URI.parse(url)
    self.connection = Net::HTTP.new(url.host, url.port)
  end

  def posts
    fetch("/admin/posts.yaml")["posts"]
  end

  def post(id)
    fetch("/admin/posts/#{id}.yaml")["post"]
  end

  def pages
    fetch("/admin/pages.yaml")
  end

  protected

  attr_accessor :connection

  def fetch(url)
    resp, data = connection.get(url, 'X-EnkiHash' => hash_request(''), 'Content-Type' => 'application/x-yaml')
    raise("Not Successful") if resp.code != '200'
    YAML.load(data)
  end

  def hash_request(data)
    Digest::SHA1.hexdigest(data + self.key)
  end
end
