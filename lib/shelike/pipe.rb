# require 'shelike/pipe/version'

module Shelike
  module Pipe
    def self.build_proc(proc, apply_proc, *args)
      case proc
      when Symbol, Method then -> { proc.to_proc.call(apply_proc.call, *args) }
      when Proc           then -> { proc.call(apply_proc.call, *args) }
      else raise ArgumentError
      end
    end

    refine Object do
      def |(arg)
        if arg.is_a? Array
          proc_or_method = arg.shift
          Shelike::Pipe.build_proc proc_or_method, -> { self }, *arg
        else
          Shelike::Pipe.build_proc arg, -> { self }
        end
      end
    end

    refine Array do
      def |(arg)
        if arg.is_a? Array
          proc_or_method = arg.shift
          Shelike::Pipe.build_proc proc_or_method, -> { self }, *arg
        else
          Shelike::Pipe.build_proc arg, -> { self }
        end
      end
    end

    refine Fixnum do
      def |(arg)
        if arg.is_a? Array
          proc_or_method = arg.shift
          Shelike::Pipe.build_proc proc_or_method, -> { self }, *arg
        else
          Shelike::Pipe.build_proc arg, -> { self }
        end
      end
    end

    refine Proc do
      def |(arg)
        if arg.is_a? Array
          proc_or_method = arg.shift
          Shelike::Pipe.build_proc proc_or_method, -> { call }, *arg
        else
          Shelike::Pipe.build_proc arg, -> { call }
        end
      end

      def silence
        call
      rescue => _
        nil
      end
    end
  end
end
