require 'celluloid'

module Uploadr
  class Log
    include Celluloid

    def puts(msg)
      Kernel.puts(msg)
    end

  end
end
