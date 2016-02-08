module Lingua
  module IT
    class Sentence

      # Takes Italian text and split it into sentences, respecting
      # generale abbreviations. It grant permission of adding more
      # abbreviations to take in account during the process.
      class << self
        attr_reader :abbreviations
        attr_reader :abbr_regex
      end

      # Common abbreviations
      TITLES = %w(sig sigg dott preg prof mr jr amn avv co stim dr egr geom ing mons on rag rev soc spett card ill gent cav) unless defined?(TITLES)
      MISC   = %w(p v femm dim ecc etc corr cc bcc all es fatt g gg id int lett ogg pag pagg cap pp tel ind v n num min sec ms abbr agg art aus) unless defined?(MISC)
      MONTHS = %w(gen feb mar apr mag giu lug ago set sett ott nov dic) unless defined?(MONTHS)
      DAYS   = %w(lun mar mer gio ven sab dom) unless defined?(DAYS)

      # Text types
      TYPES = {
        'standard'   => /["']?[A-Z][^.?!]+((?![.?!]['"]?\s["']?[A-Z][^.?!]).)+[.?!'"]+/,
        'scientific' => /["']?[A-Z][^.;:?!]+((?![.;:?!]['"]?\s["']?[A-Z][^.;:?!]).)+[.;:?!'"]+/
      }
      TYPES.default_proc = proc { |hash, key| hash[key] = /["']?[A-Z][^.?!]+((?![.?!]['"]?\s["']?[A-Z][^.?!]).)+[.?!'"]+/ }

      # Split up in sentences, use 0002 as a temporary end mark for
      # the abbreviations found, even if the regex should be enough
      # to recognize real stop point from abbreviations ones.
      # A sentences should definetly end marked only by a . or a ?
      # or a !
      def self.sentences(text, type = 'standard')
        txt = text.dup
        txt.gsub!(/\b(#{@abbr_regex})(\.)\B/i, '\10002')
        txt.gsub!(/#{TYPES[type]}/, '\2\001')
        txt.gsub!(/\b(#{@abbr_regex})(0002)/i, '\1.')
        txt.split(/01/).map { |sentence| sentence.strip }
      end

      # Add customized abbreviations to standard set
      def self.abbreviation(*abbreviations)
        @abbreviations += abbreviations
        @abbreviations.uniq!
        set_abbr_regex!
        @abbreviations
      end

      private
      # Utility method, chain up all abbreviations constants arrays
      def self.initialize_abbreviations!
        @abbreviations = TITLES + MISC + MONTHS + DAYS
        set_abbr_regex!
      end

      # Utility method, join all elements of the abbreviations arrays
      # using | as separator, making suitable for a regex.
      def self.set_abbr_regex!
        @abbr_regex = "#{@abbreviations.join('|')}"
      end

      initialize_abbreviations!

    end
  end
end
