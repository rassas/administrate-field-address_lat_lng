require 'spec_helper'

describe Administrate::Field::AddressLatLng do
  
  subject { described_class.new(field, 'address_lat_lng', :form) }
  let(:value) { 1.2345 }
  before(:each) do
    allow(subject).to receive(:options).and_return(options)
    allow(subject).to receive(:data).and_return(value)
  end
  
  context 'detected type: lng' do
    let(:field) { :lat }
    let(:options) { {} }
    describe '#which' do
      it { expect(subject.which).to eq(:lat) }
    end
  end
  context 'detected type: lng' do
    let(:field) { :lng }
    let(:options) { {} }
    describe '#which' do
      it { expect(subject.which).to eq(:lng) }
    end
  end
  
  context 'lat' do
    let(:field)   { :my_lat }
    let(:options) { {lat: true} }
    describe '#lat?' do
      it { expect(subject.lat?).to be true }
    end
    describe '#lng?' do
      it { expect(subject.lng?).to be false }
    end
    describe '#which' do
      it { expect(subject.which).to eq(:lat) }
    end
    describe 'render _form' do
      before(:each) do
        render 'fields/address_lat_lng/form', field: subject, f: mock_form
      end
      it 'sets the variable correctly' do
        expect(content :javascript).to include("var lat = 1.2345;")
      end
      it 'does not contain the map' do
        expect(content :javascript).not_to include('<div id="addresslatlngmap">')
        expect(content :javascript).not_to include("var map = L.map('addresslatlngmap')")
      end
      context 'no value set yet' do
        let(:value) { nil }
        it 'sets the variable to undefined' do
          expect(content :javascript).to include("var lat = undefined;")
        end
      end
    end
    describe 'render _show' do
      before(:each) do
        render 'fields/address_lat_lng/show', field: subject
      end
      it 'sets the variable correctly' do
        expect(content :javascript).to include("var lat = 1.2345;")
      end
      it 'does not contain the map' do
        expect(content :javascript).not_to include('<div id="addresslatlngmap">')
        expect(content :javascript).not_to include("var map = L.map('addresslatlngmap')")
      end
    end
  end
  context 'lng' do
    let(:field)   { :my_lng }
    let(:options) { {lng: true} }
    describe '#lat?' do
      it { expect(subject.lat?).to be false }
    end
    describe '#lng?' do
      it { expect(subject.lng?).to be true }
    end
    describe '#which' do
      it { expect(subject.which).to eq(:lng) }
    end
    describe '#initial' do
      it 'is default' do
        expect(subject.initial).to eq([53.8003,-1.5519])
      end
    end
    describe '#zoom' do
      it 'is default' do
        expect(subject.zoom).to eq(11)
      end  
    end
    context 'with options' do
      let(:options) { {lng: true, initial: [35.6809, 139.7672], zoom: 8} }
      describe '#intial' do
        it 'is overridden' do
          expect(subject.initial).to eq([35.6809, 139.7672])
        end
      end
      describe '#zoom' do
        it 'is overridden' do
          expect(subject.zoom).to eq(8)
        end
      end
    end
    describe 'render _form' do
      before(:each) do
        render 'fields/address_lat_lng/form', field: subject, f: mock_form
      end
      it 'sets the variable correctly' do
        expect(content :javascript).to include("var lng = 1.2345;")
      end
      it 'contains the map' do
        expect(content :javascript).to include('<div id="addresslatlngmap">')
        expect(content :javascript).to include("var map = L.map('addresslatlngmap')")
      end
      it 'contains the editing stuff' do
        expect(content :javascript).to include("map.on('click'")
      end
      context 'no value set yet' do
        let(:value) { nil }
        it 'sets the variable to undefined' do
          expect(content :javascript).to include("var lng = undefined;")
        end
      end
    end
    describe 'render _show' do
      before(:each) do
        render 'fields/address_lat_lng/show', field: subject
      end
      it 'sets the variable correctly' do
        expect(content :javascript).to include("var lng = 1.2345;")
      end
      it 'contains the map' do
        expect(content :javascript).to include('<div id="addresslatlngmap">')
        expect(content :javascript).to include("var map = L.map('addresslatlngmap')")
      end
      it 'does not contain the editing stuff' do
        expect(content :javascript).not_to include("map.on('click'")
      end
    end
  end

end
