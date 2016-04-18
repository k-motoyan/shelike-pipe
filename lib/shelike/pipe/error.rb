module Shelike
  module Pipe
    module Error
      class ResultNilError < StandardError
        def initialize
          super 'Result was nil.'
        end
      end
    end
  end
end