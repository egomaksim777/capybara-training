require 'yaml'

class Settings
  class << self
    attr_reader :config, :browsers

    def get_config
      @config ||= YAML.load_file('./config/config.yml')

      @config
    end

    def get_browsers
      @browsers ||= YAML.load_file('./config/browsers.yml')

      @browsers
    end

    def find_browser name
      get_browsers[name]
    end
  end
end
