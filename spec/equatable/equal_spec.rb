# -*- encoding: utf-8 -*-

require 'spec_helper'

describe Equatable, '#==' do
  let(:name) { 'Value' }
  let(:value) { 11 }

  let(:super_klass) {
    ::Class.new do
      include Equatable

      attr_reader :value

      def initialize(value)
        @value = value
      end
    end
  }

  let(:klass) { Class.new(super_klass) }

  let(:object) { klass.new(value) }

  subject { object == other }

  context 'with the same object' do
    let(:other) { object }

    it { should be_true }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object' do
    let(:other) { object.dup }

    it { should be_true }

    it 'is symmetric' do
      should eql(other == object)
    end
  end

  context 'with an equivalent object of a subclass' do
    let(:other) { ::Class.new(klass).new(value) }

    it { should be_false }

    it 'is not symmetric' do
      should_not eql(other == object)
    end
  end

  context 'with an equivalent object of a superclass' do
    let(:other) { super_klass.new(value) }

    it { should be_true }

    it 'is not symmetric' do
      should_not eql(other == object)
    end
  end

  context 'with an object of another class' do
    let(:other) { Class.new.new }

    it { should be_false }

    it 'is symmetric' do
      should eql(other == object)
    end
  end
end
