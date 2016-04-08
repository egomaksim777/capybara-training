require './lib/settings'

class DropboxClientWrapper
  class << self
  
    def client
      @client ||= DropboxClient.new(Settings.get_config['dropbox'])

      @client
    end

    def clean_folder
      client.metadata('/')['contents'].each do |file|
        client.file_delete(file['path'])
      end
    end

    def load_screenshot(file, name)
      client.put_file(name, file)
    end
  end
end
