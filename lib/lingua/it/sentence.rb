module Lingua
  module IT
    class Sentence

      # Takes Italian text and split it into sentences, respecting
      # generale abbreviations. It grant permission of adding more
      # abbreviations to take in account during the process.
      class << self
        attr_reader :abbreviations
        attr_reader :abbr_regex
        attr_reader :delimiters
        attr_reader :delim_regex
      end

      # Common abbreviations
      TITLES = %w(Sig Sigg Dott Preg Prof Mr Jr Amn Avv Co Stim Dr Egr Geom Ing Mons On Rag Rev Soc Spett Card Ill Gent Cav) unless defined?(TITLES)
      MISC   = %w(P V Femm Dim Ecc Etc Corr Cc Bcc All Es Fatt G Gg Id Int Lett Ogg Pag Pagg Cap Pp Tel Ind V N Num Min Sec Ms Abbr Agg Art Aus) unless defined?(MISC)
      MONTHS = %w(Gen Feb Mar Apr Mag Giu Lug Ago Set Sett Ott Nov Dic) unless defined?(MONTHS)
      DAYS   = %w(Lun Mar Mer Gio Ven Sab Dom) unless defined?(DAYS)

      # Standard delimiters
      STD = %w(. ? !)

      # Split up in sentences, use 0002 as a temporary end mark for
      # the abbreviations found, even if the regex should be enough
      # to recognize real stop point from abbreviations ones.
      # A sentences should definetly end marked only by a . or a ?
      # or a !
      def self.sentences(text)
        txt = text.dup
        txt.gsub!(/\b(#{@abbr_regex})(\.)\B/i, '\10002')
        txt.gsub!(/["']?[A-Z][^\Q#{@delim_regex}\E]+((?![\Q#{@delim_regex}\E]['"]?\s["']?[A-Z][^\Q#{@delim_regex}\E]).)+[\Q#{@delim_regex}\E'"]+/, '\2\001')
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

      # Add symbols to sentence delimters
      def self.delimiter(*delimiters)
        @delimiters += delimiters
        @delimiters.uniq!
        set_delim_regex!
        @delimiters
      end

      def self.reset_delimiter!
        @delimiters = STD
        set_delim_regex!
        @delimiters
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

      # Utility method, join all elements of the delimiters arrays
      # without a separator, making suitable for a regex.
      def self.set_delim_regex!
        @delim_regex = "#{@delimiters.join('')}"
      end

      initialize_abbreviations!
      reset_delimiter!
    end
  end
end
