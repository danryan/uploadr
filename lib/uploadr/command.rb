require 'clamp'
require 'progress_bar'

require 'uploadr/log'
require 'uploadr/queue'
require 'uploadr/worker'
require 'uploadr/bar'

module Uploadr
  class Command < Clamp::Command

    option [ '-v', '--version' ], :flag, 'print version and exit' do
      puts Uploadr::VERSION
      exit 0
    end

    subcommand 'upload', 'upload a directory of files' do
      option [ '-n', '--concurrency' ], 'NUM', 'The number of concurrent uploaders', default: 4 do |x|
        x.to_i
      end

      option [ '-d', '--directory'], 'DIR', 'The directory to upload',
        multivalued: true, default: [], attribute_name: :directories

      option [ '-c', '--config'], 'CONFIG', 'The config file to use', default: "#{ENV['HOME']}/.uploadrc"

      def execute
        self_read, self_write = IO.pipe

        %w( INT TERM ).each do |signal|
          trap signal do
            raise Interrupt
          end
        end

        begin

          Uploadr.worker_count = concurrency
          Uploadr.directories = directories
          Uploadr.config_file = config

          Uploadr::Queue.supervise_as(:queue)
          Uploadr::Log.supervise_as(:log)
          Uploadr::Bar.supervise_as(:bar)

          pool = Uploadr::Worker.pool(size: Uploadr.worker_count) #, args: [ queue ])

          Celluloid::Actor[:queue].wait_completion

        rescue Interrupt
          pool.terminate

          Celluloid::Actor[:bar].terminate
          Celluloid::Actor[:log].terminate
          Celluloid::Actor[:queue].terminate

          exit 0
        end

        # worker = Uploadr::Worker.new(queue, config)
        # puts client.connection.test.login
        # get list of files inside directories
        # work off queue 'til done
        # profit?
      end

    end
  end
end
