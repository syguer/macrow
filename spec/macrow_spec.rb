require 'spec_helper'

describe Macrow do
  it 'has a version number' do
    expect(Macrow::VERSION).not_to be nil
  end

  describe '#apply_all_rules' do
    context "when str includes rule string" do
      let (:macro) { HogeMacro.new }
      let (:str) { '${ping}' }

      subject { macro.apply_all_rules(str) }

      it { is_expected.to eq 'pong' }
    end

    context "when str does NOT include rule string" do
      let (:macro) { HogeMacro.new }
      let (:str) { 'hoge' }

      subject { macro.apply_all_rules(str) }

      it { is_expected.to eq 'hoge' }
    end

    context "when object given" do
      let (:macro) { HogeMacro.new }
      let (:str) { '${length}' }
      let (:object) { ['one', 'two'] }

      subject { macro.apply_all_rules(str, object) }

      it { is_expected.to eq '2' }
    end

    context "when unexpected object given and method not found" do
      let (:macro) { MethodNotFoundMacro.new }
      let (:str) { '${hoge}' }
      let (:object) { ['one', 'two'] }

      subject { macro.apply_all_rules(str) }

      it { expect{ subject }.to raise_error Macrow::ReplaceError }
    end

    context "when class parameter has overriden" do
      let (:macro) { OverRideMacro.new }

      context "when before rule string" do
        let (:str) { '${ping}' }

        subject { macro.apply_all_rules(str) }

        it { is_expected.to eq '${ping}' }
      end

      context "when after rule string" do
        let (:str) { '{{ping}}' }

        subject { macro.apply_all_rules(str) }

        it { is_expected.to eq 'pong' }
      end
    end
  end
end
