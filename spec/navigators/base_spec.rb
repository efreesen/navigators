require './lib/navigators/base'

describe Navigators::Base do
  let(:listener) { double }

  describe '#listener' do
    subject { described_class.new(listener) }

    it 'returns listener' do
      expect(subject.listener).to eq listener
    end
  end

  describe '#index' do
    let(:collection) { [1, 2, 3] }

    subject { described_class.new(listener) }

    before do
      allow(subject).to receive(:get_resources).and_return(collection)
    end

    it 'calls render render_resources method on listener' do
      expect(listener).to receive(:render_resources).with(collection)

      subject.index
    end
  end

  describe '.index' do
    let(:instance) { described_class.new(listener) }

    before do
      allow(described_class).to receive(:new).with(listener).and_return(instance)
    end

    it 'calls #index' do
      expect(instance).to receive(:index)

      described_class.index(listener)
    end
  end

  describe '#save' do
    context 'when id is passed' do
      let(:resource) { double }
      let(:id) { 123456 }
      let(:params) { { name: 'name', id: 123456 } }

      subject { described_class.new(listener) }

      before do
        allow(subject).to receive(:resource).and_return(resource)
      end

      context 'and save is successful' do
        before do
          allow(subject).to receive(:save_resource).with(params).and_return(true)
        end

        it 'calls listener save_success method' do
          expect(listener).to receive(:save_success).with(resource, 'edit success')

          subject.save(params, id)
        end
      end

      context 'and save fails' do
        before do
          allow(subject).to receive(:save_resource).with(params).and_return(false)
        end

        it 'calls listener save_failure method' do
          expect(listener).to receive(:save_failure).with(resource, 'edit error')

          subject.save(params, id)
        end
      end
    end

    context 'when no id is passed' do
      let(:resource) { double }
      let(:params) { { name: 'name' } }

      subject { described_class.new(listener) }

      before do
        allow(subject).to receive(:resource).and_return(resource)
      end

      context 'and save is successful' do
        before do
          allow(subject).to receive(:save_resource).with(params).and_return(true)
        end

        it 'calls listener save_success method' do
          expect(listener).to receive(:save_success).with(resource, 'new success')

          subject.save(params)
        end
      end

      context 'and save fails' do
        before do
          allow(subject).to receive(:save_resource).with(params).and_return(false)
        end

        it 'calls listener save_failure method' do
          expect(listener).to receive(:save_failure).with(resource, 'new error')

          subject.save(params)
        end
      end
    end
  end

  describe '.save' do
    let(:instance) { described_class.new(listener) }

    before do
      allow(described_class).to receive(:new).with(listener).and_return(instance)
    end

    it 'calls #save' do
      expect(instance).to receive(:save)

      described_class.save({}, listener, 1)
    end
  end

  describe '#destroy' do
    context 'when id is passed' do
      let(:resource) { double }
      let(:id) { 123456 }

      subject { described_class.new(listener) }

      before do
        allow(subject).to receive(:resource).and_return(resource)
      end

      context 'and destroy is successful' do
        before do
          allow(subject).to receive(:destroy_resource).and_return(true)
        end

        it 'calls listener save_success method' do
          expect(listener).to receive(:save_success).with(resource, 'destroy success')

          subject.destroy(id)
        end
      end

      context 'and destroy fails' do
        before do
          allow(subject).to receive(:destroy_resource).and_return(false)
        end

        it 'calls listener save_failure method' do
          expect(listener).to receive(:save_failure).with(resource, 'destroy error')

          subject.destroy(id)
        end
      end
    end

    context 'when no id is passed' do
      let(:resource) { double }
      let(:params) { { name: 'name' } }

      subject { described_class.new(listener) }

      before do
        allow(subject).to receive(:resource).and_return(resource)
        allow(subject).to receive(:destroy_resource).and_return(false)
      end

      it 'returns false' do
        expect(subject.destroy(nil)).not_to be
      end
    end
  end

  describe '.destroy' do
    let(:instance) { described_class.new(listener) }

    before do
      allow(described_class).to receive(:new).with(listener).and_return(instance)
    end

    it 'calls #destroy' do
      expect(instance).to receive(:destroy)

      described_class.destroy(1, listener)
    end
  end
end
