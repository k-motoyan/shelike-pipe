module Shelike
  module Pipe
    def self.build_proc(proc, apply_proc, *args)
      case proc
      when Symbol, Method then -> { proc.to_proc.call(apply_proc.call, *args) }
      when Proc           then -> { proc.call(apply_proc.call, *args) }
      else raise ArgumentError
      end
    end

    def self.pipe(object, arg)
      if arg.is_a? Array
        proc_or_method = arg.shift
        Shelike::Pipe.build_proc proc_or_method, -> { object }, *arg
      else
        Shelike::Pipe.build_proc arg, -> { object }
      end
    end

    refine Object do
      def |(arg)
        Shelike::Pipe.pipe(self, arg)
      end
    end

    refine Array do
      def |(arg)
        Shelike::Pipe.pipe(self, arg)
      end
    end

    refine Fixnum do
      def |(arg)
        Shelike::Pipe.pipe(self, arg)
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

      def ^(proc)
        call.tap { |r| raise Shelike::Pipe::Error::ResultNilError if r.nil? }
      rescue => e
        proc.call(e)
        nil
      end
    end

    refine NilClass do
      def |(_)
        nil
      end

      def ^(_)
        nil
      end
    end
  end
end
