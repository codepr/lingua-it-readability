# coding: utf-8
require File.dirname(__FILE__) + "/../../spec_helper"

describe Lingua::IT::Syllable do

  subject { Lingua::IT::Syllable }

  describe "#syllables" do
    let(:input) { "Andiamo alla farmacia, leggendo geografia." }
    let(:output) { subject.syllables(input) }

    it "should correctly hyphenate the sentence" do
      expect(output.length).to eq(17)
      expect(output[0]).to eq "An"
      expect(output[1]).to eq "dia"
      expect(output[2]).to eq "mo"
      expect(output[3]).to eq "al"
      expect(output[4]).to eq "la"
      expect(output[5]).to eq "far"
      expect(output[6]).to eq "ma"
      expect(output[7]).to eq "ci"
      expect(output[8]).to eq "a"
      expect(output[9]).to eq "leg"
      expect(output[10]).to eq "gen"
      expect(output[11]).to eq "do"
      expect(output[12]).to eq "ge"
      expect(output[13]).to eq "o"
      expect(output[14]).to eq "gra"
      expect(output[15]).to eq "fi"
      expect(output[16]).to eq "a"
    end

    let(:case_1_input) { "Finestra" }
    let(:case_1_output) { subject.syllables(case_1_input) }

    it "should correctly hyphenate the word 'finestra'" do
      expect(case_1_output.length).to eq(3)
      expect(case_1_output[0]).to eq "Fi"
      expect(case_1_output[1]).to eq "ne"
      expect(case_1_output[2]).to eq "stra"
    end

    let(:case_2_input) { "Attività" }
    let(:case_2_output) { subject.syllables(case_2_input) }

    it "should correctly hyphenate the word 'attività'" do
      expect(case_2_output.length).to eq(4)
      expect(case_2_output[0]).to eq "At"
      expect(case_2_output[1]).to eq "ti"
      expect(case_2_output[2]).to eq "vi"
      expect(case_2_output[3]).to eq "tà"
    end
  end
end
