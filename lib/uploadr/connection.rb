require 'flickraw'

module Uploadr
  class Connection

    attr_accessor :config

    def initialize
      @config = Uploadr.config
    end
    
    def upload(photo)
      connection.upload_photo photo,
        is_public: 0,
        is_friend: 0,
        is_family: 0,
        safety_level: 1,
        content_type: 1,
        hidden: 2
    end

    private

      def connection
        connection = FlickRaw::Flickr.new

        if config['access_token'] && config['access_secret']
          connection.access_token = config['access_token']
          connection.access_secret = config['access_secret']
        else
          token = connection.get_request_token
          auth_url = connection.get_authorize_url(token['oauth_token'], :perms => 'write')

          puts "Open this URL, follow the instructions, and paste the number here:"
          puts auth_url
          verification_token = STDIN.gets.strip

          connection.get_access_token token['oauth_token'], token['oauth_token_secret'], verification_token

          login = connection.test.login

          config.params['access_token'] = connection.access_token
          config.params['access_secret'] = connection.access_secret
          config.write(config.config_file)

          File.open(config.config_file, 'w') do |file|
            config.write(file)
          end
        end

        connection
      end

  end
end
