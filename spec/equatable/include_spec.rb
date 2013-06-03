# -*- encoding: utf-8 -*-

require 'spec_helper'

describe Equatable, '#include' do
  let(:name) { 'Value' }
  let(:object) { described_class }

  context 'without attributes' do
    let(:klass) { ::Class.new }

    subject { klass.new }

    before {
      klass.stub(:name).and_return name
      klass.send(:include, object)
    }

    it { should respond_to :compare? }

    it { should be_instance_of klass }

    describe '#inspect' do
      it { subject.inspect.should eql('#<Value>') }
    end

    describe '#hash' do
      it { subject.hash.should eql([klass].hash) }
    end

    describe '#eql?' do
      context 'when objects are similar' do
        let(:other) { subject.dup }

        it { subject.eql?(other).should be_true }
      end

      context 'when objects are different' do
        let(:other) { stub('other') }

        it { subject.eql?(other).should be_false }
      end
    end

    describe '#==' do
      context 'when objects are similar' do
        let(:other) { subject.dup }

        it { (subject == other).should be_true }
      end

      context 'when objects are different' do
        let(:other) { stub('other') }

        it { (subject == other)}
      end
    end

    context 'equivalence relation' do
      let(:other) { subject.dup }
      let(:another) { other.dup }

      it 'is not equal to nil reference' do
         expect(subject.eql?(nil)).to be_false
      end

      it 'is reflexive' do
        expect(subject.eql?(subject)).to be_true
      end

      it 'is symmetric' do
        expect(subject.eql?(other)).to eql( other.eql?(subject) )
      end

      it 'is transitive' do
        expect(subject.eql?(other) && other.eql?(another)).to eql(subject.eql?(another))
      end
    end
  end

  context 'with attributes' do
    let(:value) { 11 }
    let(:klass) {
      ::Class.new do
        include Equatable

        attr_reader :value

        def initialize(value)
          @value = value
        end
      end
    }

    before {
      klass.stub(:name).and_return name
    }

    subject { klass.new(value) }

    it 'dynamically defines #hash method' do
      klass.method_defined?(:hash).should be_true
    end

    it 'dynamically defines #inspect method' do
      klass.method_defined?(:inspect).should be_true
    end

    it { should respond_to :compare? }

    it { should respond_to :eql? }

    describe '#eql?' do
      context 'when objects are similar' do
        let(:other) { subject.dup }

        it { subject.eql?(other).should be_true }
      end

      context 'when objects are different' do
        let(:other) { stub('other') }

        it { subject.eql?(other).should be_false }
      end
    end

    describe '#==' do
      context 'when objects are similar' do
        let(:other) { subject.dup }

        it { (subject == other).should be_true }
      end

      context 'when objects are different' do
        let(:other) { stub('other') }

        it { (subject == other).should be_false }
      end
    end

    describe '#inspect' do
      it { subject.inspect.should eql('#<Value value=11>') }
    end

    describe '#hash' do
      it { subject.hash.should eql( ([klass] + [value]).hash) }
    end

    context 'equivalence relation' do
      let(:other) { subject.dup }
      let(:another) { other.dup }

      it 'is not equal to nil reference' do
         expect(subject.eql?(nil)).to be_false
      end

      it 'is reflexive' do
        expect(subject.eql?(subject)).to be_true
      end

      it 'is symmetric' do
        expect(subject.eql?(other)).to eql( other.eql?(subject) )
      end

      it 'is transitive' do
        expect(subject.eql?(other) && other.eql?(another)).to eql(subject.eql?(another))
      end
    end
  end
end
