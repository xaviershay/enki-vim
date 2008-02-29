require 'net/http'
require 'digest/sha1'
require 'yaml'
require 'time'

def hash_request(data)
  salt = '1bac7e3c3f67f2ccebc0a1529e9850cd97e23a24'
  Digest::SHA1.hexdigest(data + salt)
end
