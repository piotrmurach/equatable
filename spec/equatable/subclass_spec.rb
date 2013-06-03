# -*- encoding: utf-8 -*-

require 'spec_helper'

describe Equatable, 'subclass' do
  let(:name) { 'Value' }

  context 'when subclass' do
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
    let(:subclass) { ::Class.new(klass) }

    before {
      klass.stub(:name).and_return name
    }

    subject { subclass.new(value) }

    it { subclass.superclass.should == klass }

    it { should respond_to :value }

    describe '#inspect' do
      it { subject.inspect.should eql('#<Value value=11>') }
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
  end

end
