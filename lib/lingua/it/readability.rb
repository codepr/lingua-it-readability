# coding: utf-8
prefix = File.dirname(__FILE__) + "/"
$LOAD_PATH.unshift prefix

Dir.glob(prefix + "**/*.rb").each do |f|
  require File.expand_path(f)
end

module Lingua
  module IT
    class Readability
      attr_reader :text
      attr_reader :type
      attr_reader :paragraphs
      attr_reader :sentences
      attr_reader :words
      attr_reader :frequencies

      # Initialize the sample with +text+
      def initialize(text, type = 'standard')
        @text                = text.dup
        @type                = type
        @paragraphs          = Lingua::IT::Paragraph.paragraphs(self.text)
        @sentences           = Lingua::IT::Sentence.sentences(self.text, self.type)
        @words               = []
        @frequencies         = {}
        @frequencies.default = 0
        @syllables           = Lingua::IT::Syllable.syllables(self.text)
        count_words
      end

      # The number of paragraphs in the sample. A paragraph is defined as a
      # newline followed by one or more empty or whitespace-only lines.
      def num_paragraphs
        paragraphs.length
      end

      # The number of sentences in the sample. The meaning of a "sentence" is
      # defined by Lingua::IT::Sentence.
      def num_sentences
        @sentences.length
      end

      # The number of characeters in the sample. A character is defined as a
      # single letter, not taking account of punctuation and spaces
      def num_chars
        @text.dup.gsub(/[[:punct:]][[:space:]]/, '').scan(/[a-zA-Z0-9_Èàòèéìù\(\)\[\]\{\}]/i).length
      end
      alias :num_characters :num_chars

      # The number of words in the sample. A word is defined as a sequence of
      # characters, not taking account of punctuation and spaces, see private
      # method +count_words+ for additional info about a word definition
      def num_words
        words.length
      end

      # The total number of syllables in the text sample. Syllables are defined
      # in Lingua::IT::Syllable.
      def num_syllables
        @syllables.length
      end

      # The number of different unique words used in the text sample.
      def num_unique_words
        @frequencies.keys.length
      end

      # An array containing each unique word used in the text sample.
      def unique_words
        @frequencies.keys
      end

      # The number of occurences of the word +word+ in the text sample.
      def occurrences(word)
        @frequencies[word]
      end

      # The average number of words per sentence.
      def words_per_sentence
        ((words.length.to_f / sentences.length.to_f) * 100).round / 100.0
      end

      # The average number of syllables per word. The syllable count is
      # performed by Lingua::IT::Syllable, and so may not be completely
      # accurate
      def syllables_per_word
        ((@syllables.length.to_f / words.length.to_f) * 100).round / 100.0
      end

      # Gulpease index of readability expressly calibrated to suit italian
      # text samples.
      # An index < 40 means a low readable sample, between 40 and 60 it
      # represents a medium readable sample, over 60 a well written sample
      # easily readable by an under 16 person.
      def gulpease
        89 + (((300 * num_sentences) - (10 * num_chars)) / num_words)
      end

      # Flesch index of readability expressly calibrated to suit italian
      # text samples, derived from U.S. Flesch index.
      # An index < 40 means a low readable sample, between 40 and 60 it
      # represents a medium readable sample, over 60 a well written sample
      # easily readable by an under 16 person.
      def flesch
        ((206.0 - (65.0 * (num_syllables.to_f / num_words.to_f)) -
          ((num_words.to_f / num_sentences.to_f))) * 100).round / 100.0
      end

      # A nicely formatted report on the sample, showing most the useful
      # stats
      def report
        sprintf "Number of paragraphs           %d \n" <<
                "Number of sentences            %d \n" <<
                "Number of words                %d \n" <<
                "Number of characters           %d \n\n" <<
                "Average words per sentence     %.2f \n" <<
                "Average syllables per word     %.2f \n\n" <<
                "Gulpease score                 %2.2f \n" <<
                "Flesch score                   %2.2f \n",
                num_paragraphs, num_sentences, num_words, num_characters,
                words_per_sentence, syllables_per_word, gulpease,
                flesch
      end

      private

      # Nnumber of words in the sample. A words is represented by a sequence
      # of single characters exlucding punctuation, except for all kind of
      # parenthesis like () [] and {}. Being calibrated for italian language
      # it takes in account even accented characters.
      def count_words
        @words = @text.dup.gsub(/[^\wÈèòàù\(\)\[\]\{\}]/i, ' ').strip.split(/\s+/)
        @words.each do |word|
          @frequencies[word] += 1
        end
      end
    end
  end
end
