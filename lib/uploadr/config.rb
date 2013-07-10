require 'parseconfig'

module Uploadr
  module Config
    VALID_OPTIONS_KEYS = [
      :worker_count,
      :directories,
      :config,
      :config_file
    ]

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def config
      @config ||= ParseConfig.new(File.expand_path(config_file))
    end

    def reset
      self.config = nil
      self.config_file = nil
      self.worker_count = nil
      self.directories = nil
    end

  end
end