# coding: utf-8
require File.dirname(__FILE__) + "/../../spec_helper"

describe Lingua::IT::Readability do

  subject { Lingua::IT::Readability.new(
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
    dimenticato: \"La loro accoglienza mi ha travolto\"" ) }

  describe "#num_chars" do
    let(:output) { subject.num_chars }
    it "should calculate the correct number of characters" do
      expect(output).to eq(914)
    end
  end

  describe "#num_words" do
    let(:output) { subject.num_words }
    it "should calculate the correct number of words" do
      expect(output).to eq(191)
    end
  end

  describe "#num_sentences" do
    let(:output) { subject.num_sentences }
    it "should calculate the correct number of sentences" do
      expect(output).to eq(11)
    end
  end

  describe "#num_unique_words" do
    let(:output) { subject.num_unique_words }
    it "should calculate the correct number of different words " do
      expect(output).to eq(141)
    end
  end

  describe "#num_syllables" do
    let(:output) { subject.num_syllables }
    it "should calculate the correct number of syllables " do
      expect(output).to eq(401)
    end
  end

  describe "#occurrences" do
    let(:output) { subject.occurrences('attività') }
    it "should calculate the correct number of occurences of the word 'attività'" do
      expect(output).to eq(2)
    end
  end

  describe "#words_per_sentence" do
    let(:output) { subject.words_per_sentence }
    it "should calculate the average number of words per sentence" do
      expect(output).to eq(17.36)
    end
  end

  describe "#syllables_per_word" do
    let(:output) { subject.syllables_per_word }
    it "should calculate the average number of syllables per word" do
      expect(output).to eq(2.1)
    end
  end

  describe "#gulpease" do
    let(:output) { subject.gulpease }
    it "should calculate the correct gulpease index" do
      expect(output).to eq(58)
    end
  end

  describe "#flesch" do
    let(:output) { subject.flesch }
    it "should calculate the correct flesch index" do
      expect(output).to eq(52.17)
    end
  end

end
