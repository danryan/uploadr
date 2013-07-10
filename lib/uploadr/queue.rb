require 'celluloid'

module Uploadr
  class Queue
    include Celluloid

    attr_accessor :files

    def initialize
      @worker_count = Uploadr.worker_count
      @files = []
      Uploadr.directories.each do |dir|
        @files << Dir.glob("#{File.expand_path(dir)}/**/*.jpg", File::FNM_CASEFOLD)
      end
      @files.flatten!
    end

    def shift
      @files.shift
    end

    def completed
      @worker_count -= 1
      if @worker_count == 0
        signal(:all_completed)
      end
    end

    def wait_completion
      wait(:all_completed)
      Actor[:log].puts "Shutting down..."
    end

  end
end
