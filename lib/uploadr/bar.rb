require 'progress_bar'

module Uploadr
  class Bar
    include Celluloid

    def initialize
      @progress_bar = ProgressBar.new(Actor[:queue].files.length)
    end

    def increment
      @progress_bar.increment!
    end
  end
end