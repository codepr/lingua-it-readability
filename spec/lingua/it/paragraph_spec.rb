require File.dirname(__FILE__) + "/../../spec_helper"

describe Lingua::IT::Paragraph do
  describe "#paragraphs" do
    it "should return paragraphs with extra whitespace in the line breaks" do
      text = "Ok.\n    \nTest."
      result = Lingua::IT::Paragraph.paragraphs(text)
      expect(result.length).to eq(2)
      expect(result[0]).to eq "Ok."
      expect(result[1]).to eq "Test."
    end

    it "should break up paragraphs with > 2 line breaks" do
      text = "Ok.\n\n\nTest."
      result = Lingua::IT::Paragraph.paragraphs(text)
      expect(result.length).to eq(2)
      expect(result[0]).to eq "Ok."
      expect(result[1]).to eq "Test."
    end

    it "should ignore trailing newline chars" do
      text = "Ok.\n  \n\nTest.\n  \r\n  \n\n"
      result = Lingua::IT::Paragraph.paragraphs(text)
      expect(result.length).to eq(2)
      expect(result[0]).to eq "Ok."
      expect(result[1]).to eq "Test."
    end
  end
end
