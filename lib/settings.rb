require 'yaml'

class Settings
  class << self
    attr_reader :config, :browsers

    def getting_config
      @config ||= YAML.load_file('./config/config.yml')

      @config
    end

    def getting_browsers
      @browsers ||= YAML.load_file('./config/browsers.yml')

      @browsers
    end

    def find_browser(name)
      getting_browsers[name]
    end
  end
end
