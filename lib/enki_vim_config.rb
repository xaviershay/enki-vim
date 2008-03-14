class EnkiVimConfig
  class << self
    def config
      YAML.load(IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', 'config.yml'))))
    end

    def [](key)
      config[key.to_s]
    end
  end
end
