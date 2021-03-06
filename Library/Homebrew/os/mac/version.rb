require "version"

module OS
  module Mac
    class Version < ::Version
      SYMBOLS = {
        high_sierra: "10.13",
        sierra: "10.12",
        el_capitan: "10.11",
        yosemite: "10.10",
        mavericks: "10.9",
        mountain_lion: "10.8",
        lion: "10.7",
        snow_leopard: "10.6",
        leopard_64: "10.5",
        leopard: "10.5",
        tiger: "10.4",
        x86_64_linux:  "0",
      }.freeze

      def self.from_symbol(sym)
        str = SYMBOLS.fetch(sym) do
          raise ArgumentError, "unknown version #{sym.inspect}"
        end
        new(str)
      end

      def initialize(*args)
        super
        @comparison_cache = {}
      end

      def <=>(other)
        @comparison_cache.fetch(other) do
          v = SYMBOLS.fetch(other) { other.to_s }
          @comparison_cache[other] = super(Version.new(v))
        end
      end

      def to_sym
        SYMBOLS.invert.fetch(@version) { :dunno }
      end

      def pretty_name
        to_sym.to_s.split("_").map(&:capitalize).join(" ")
      end
    end
  end
end
