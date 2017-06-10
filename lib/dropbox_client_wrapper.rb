require './lib/settings'

# Ability to upload/delete files to/from Dropbox
class DropboxClientWrapper
  class << self

    def client
      @client ||= DropboxClient.new(Settings.getting_config['dropbox'])

      @client
    end

    def clean_folder
      client.metadata('/')['contents'].each do |file|
        client.file_delete(file['path'])
      end
    end

    def upload_file(file, name)
      client.put_file(name, file)
    end
  end
end
