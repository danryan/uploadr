require 'uploadr/connection'

module Uploadr
  class Worker
    include Celluloid

    attr_accessor :connection

    def initialize
      @connection = Uploadr::Connection.new
      async.run
      # @connection = get_connection
    end

    def run
      loop do
        file = Actor[:queue].shift
        break unless file
        # Actor[:out].puts "[#{thread_id}] Uploading file: #{file}"
        upload(file)
        # Actor[:out].puts "[#{thread_id}] Finished uploading file: #{file}"
        # Actor[:out].puts "#{queue.files.length} photos remaining"
        Actor[:bar].increment
      end

      Actor[:queue].async.completed
    end

    private

      def thread_id
        '%x' % Thread.current.object_id
      end

      def upload(photo)
        connection.upload(photo)
      end

  end
end
