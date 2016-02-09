# coding: utf-8
module Lingua
  module IT
    module Syllable

      # This module is inspired by the Perl Lingua::IT::Hyphenation module.
      # However, it uses a different (though not larger) set of patterns to
      # compensate for the 'special cases' which arise out of Italian's
      # irregular orthography. A number of extra patterns (particularly for
      # derived word forms) means that this module is somewhat more accurate
      # than the Perl original.
      # It's not perfect, some extreme special cases could not be handled
      # correctly, trough it's well realiable 90% of times, at least in the
      # number of syllables, that really matters for the Flesch index.

      V = "[aeiouàèéìòù]"
      C = "[b-df-hj-np-tv-z]"
      Y = "[b-df-hj-mp-tv-z]"
      S = "iut"
      X = "fi|aci"
      Z = "i[aeo]"

      def self.syllables(text)
        words = text.dup.split(/[^a-zA-Zàèéìòù'0-9]+/)
        hyphenation = ""
        words.each do |word|
          word.gsub!(/(#{V})(#{S})/i, '\1=iu=t')
          word.gsub!(/(#{V})(#{Z})/i, '\1=\2')
          word.gsub!(/(#{X})(#{V})/i, '\1=\2')
          word.gsub!(/(#{C})(#{V})(#{V})(#{Y})/, '\1\2=\3=\4')
          word.gsub!(/(#{V})([bcfgptv][lr])/i, '\1=\2')
          word.gsub!(/(#{V})([cg]h)/i, '\1=\2')
          word.gsub!(/(#{V})(gn)/i, '\1=\2')
          word.gsub!(/(#{C})\1/i, '\1=\1')
          word.gsub!(/(s#{C})/i, '=\1')
          1 while word.gsub!(/(#{V}*#{C}+#{V}+)(#{C}#{V})/i, '\1=\2')
          1 while word.gsub!(/(#{V}*#{C}+#{V}+#{C})(#{C})/i, '\1=\2')
          word.gsub!(/^(#{V}+#{C})(#{C})/i, '\1=\2')
          word.gsub!(/^(#{V}+)(#{C}#{V})/i, '\1=\2')
          word.sub!(/^=/, '')
          word.sub!(/=$/, '')
          word.gsub!(/=+/,'=');
          # special cases
          word.gsub!(/(le)([oa]n)/i, '\1=\2')
          word.gsub!(/(le)([oa])(an)/i, '\1=\2=\3')
          word.gsub!(/(spe)=(le)=(o)/i, '\1=\2\3')
          word.gsub!(/([gd]i)=(#{V})/i, '\1\2')
          word.gsub!(/(ni)=(#{V})/i, '\1\2')
          word.gsub!(/=(e)=(l)/i, '\1\2')
          hyphenation += "#{word}="
        end
        hyphenation.split('=')
      end
    end
  end
end
