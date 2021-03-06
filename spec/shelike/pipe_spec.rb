require 'json'

RSpec.describe Shelike::Pipe do
  using Shelike::Pipe

  describe 'build_proc' do
    context 'when gave the parameter except Proc, Method, Symbol' do
      it do
        expect { Shelike::Pipe.build_proc('test') }.to(
          raise_error ArgumentError
        )
      end
    end
  end

  describe 'object pipe' do
    context 'given symbol' do
      subject { ('test' | :upcase).call }
      it { is_expected.to eq 'TEST' }
    end

    context 'given proc' do
      subject { ('test' | :upcase.to_proc).call }
      it { is_expected.to eq 'TEST' }
    end
  end

  context 'array pipe' do
    subject { ([2, 1, 3] | :sort).call }
    it { is_expected.to eq [1, 2, 3] }
  end

  context 'number pipe' do
    subject { (1 | [:*, 2]).call }
    it { is_expected.to eq 2 }
  end

  context 'proc pipe' do
    subject { (-> { 'a' } | :upcase).call }
    it { is_expected.to eq 'A' }
  end

  describe 'exception block' do
    subject { proc }

    let(:proc) do
      json_string \
        | JSON.method(:parse) ^ ->(_) {} \
        | [:fetch, 'a']       ^ ->(_) {}
    end

    context 'not except' do
      let(:json_string) { '{ "a": 1 }' }
      it { is_expected.to eq 1 }
    end

    context 'except' do
      let(:json_string) { '{ a: 1 }' }
      it { is_expected.to be_nil }
    end
  end
end