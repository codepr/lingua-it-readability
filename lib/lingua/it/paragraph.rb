module Lingua
  module IT
    module Paragraph

      # Split the sample in paragraph. A paragraph is defined by
      # a sequence of sentences followed by one or more \n, \r\t
      # if in Windows env.
      def self.paragraphs(text)
        text.dup.split(/(?:\n[\r\t ]*)+/).collect { |p| p.strip }
      end
    end
  end
end
