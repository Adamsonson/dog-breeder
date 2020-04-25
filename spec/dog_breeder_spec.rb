# frozen_string_literal: true

require 'spec_helper'
describe 'Dog Breed' do
  context 'to parse image API with' do
    let(:client) { ApiClient.new }

    context 'incorrect input name' do
      let(:image)  { 'Breed not found (master breed does not exist)' }
      let(:name)   { 'huskyy' }

      it 'returns not found status' do
        allow(client).to receive(:fetch_all_images)
          .with(name)
          .and_return(image)

        response = Breed.new(name).fetch_images

        expect(response).to eq image
      end
    end

    context 'correct input name' do
      let(:image)  { 'https://images.dog.ceo/breeds/husky/' }
      let(:name)   { 'husky' }

      it 'returns array of image urls' do
        allow(client).to receive(:fetch_all_images)
          .with(name)
          .and_return(image)

        response = Breed.new(name).fetch_images
        expect(response).to be_a(Array).and all include(image)
      end
    end
  end
end
