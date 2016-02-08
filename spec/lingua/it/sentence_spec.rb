# coding: utf-8
require File.dirname(__FILE__) + "/../../spec_helper"

describe Lingua::IT::Sentence do

  describe "#sentences" do
    subject { Lingua::IT::Sentence }
    let(:input) {
      "Torna a giocare. Dopo lo scandalo, i tradimenti coniugali e lo stop
    all’attività. Tiger Woods, ovvero quello che era il golfista più forte del
    mondo torna a calcare il green e si sottoppone all’assedio del media. Parlando
    di tutto: dal tradimento nei confronti della moglie all’ammissione di aver
    avuto decine di amanti al punto da diventare \"sesso-dipendente\", alla
    decisione di confessare tutto e di farsi curare pur di tornare a giocare.
    Nella sua prima conferenza stampa dopo la tempesta, tenuta ad Augusta, in
    Georgia, per il suo ritorno alla attività agonistica in occasione dei Masters
    americani, Woods recita molti 'mea culpa'. Conditi da alcuni \"mi spiace\" e
    \"adesso sono un uomo nuovo\". Per il campione, vincere sarà ormai
    \"irrilevante\" se paragonato \"al male provocato alla famiglia\". Woods
    spiega che in questi cinque mesi ha \"guardato dentro se stesso\" ed è stato
    \"duro\". Soprattutto per aver causato l’ulteriore \"assalto della stampa
    sulla vita di mia moglie e dei miei figli\". Per questo, aggiunge, la moglie
    ha deciso di non seguirlo al torneo di Augusta. I fan, invece, non l’hanno
    dimenticato: \"La loro accoglienza mi ha travolto\"" }

    let(:output) { subject.sentences(input) }

    it "should get the correct number of sentences" do
      expect(output.length).to eq(11)
    end

    let(:abbr_input) { "Sig. Andrea Giacomo Baldan a suo dire mr. Washington. Ciao." }
    let(:abbr_output) { subject.sentences(abbr_input) }

    it "should get the correct number of sentences even with abbreviations" do
      expect(abbr_output.length).to eq(2)
      expect(abbr_output[0]).to eq('Sig. Andrea Giacomo Baldan a suo dire mr. Washington.')
      expect(abbr_output[1]).to eq('Ciao.')
    end

    let(:abbr_in_word_in) { "Sig. Andrea Giacomo Baldan a suo dire mr. Washington. Ciao Maggio. Giugno." }
    let(:abbr_in_word_out) { subject.sentences(abbr_in_word_in) }

    it "should recognize the correct sentences even with abbreviations contained in words" do
      expect(abbr_in_word_out.length).to eq(3)
      expect(abbr_in_word_out[0]).to eq('Sig. Andrea Giacomo Baldan a suo dire mr. Washington.')
      expect(abbr_in_word_out[1]).to eq('Ciao Maggio.')
      expect(abbr_in_word_out[2]).to eq('Giugno.')
    end

    let(:url_input) { "Sig. Andrea Giacomo Baldan visiti il sito https://github.com/codepr/lingua.git. Troverà interesse." }
    let(:url_output) { subject.sentences(url_input) }

    it "should get the correct number of sentences even with url and abbreviations" do
      expect(url_output.length).to eq(2)
      expect(url_output[0]).to eq('Sig. Andrea Giacomo Baldan visiti il sito https://github.com/codepr/lingua.git.')
      expect(url_output[1]).to eq('Troverà interesse.')
    end

    let(:sci_input) {"Abbreviazioni:\n- Gen;\n- Feb;\n- Mar;"}
    let(:sci_output) { subject.sentences(sci_input, 'scientific') }

    it "should get the correct number of sentences in a scientific list" do
      expect(sci_output.length).to eq(4)
      expect(sci_output[0]).to eq('Abbreviazioni:')
      expect(sci_output[1]).to eq('- Gen;')
      expect(sci_output[2]).to eq('- Feb;')
      expect(sci_output[3]).to eq('- Mar;')
    end

  end

  describe "#abbreviation" do
    subject { Lingua::IT::Sentence }
    let(:add_abbr_output) { subject.abbreviation('suo', 'mio') }

    it "should add the abbreviations to the list" do
      expect(add_abbr_output).to include('suo')
      expect(add_abbr_output).to include('mio')
    end

    let(:new_abbr_input) { "Sig. Andrea Giacomo Baldan suo. Zio è alto. Mio." }
    let(:new_abbr_output) { subject.sentences(new_abbr_input) }

    it "should recognize the correct number of sentences with new abbreviations added" do
      expect(new_abbr_output.length).to eq(2)
      expect(new_abbr_output[0]).to eq('Sig. Andrea Giacomo Baldan suo. Zio è alto.')
      expect(new_abbr_output[1]).to eq('Mio.')
    end
  end
end
