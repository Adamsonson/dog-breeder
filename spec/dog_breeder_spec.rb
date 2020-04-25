# frozen_string_literal: true

require 'spec_helper'
describe 'Dog Breed' do
  context 'to parse API with' do
    let(:client) { ApiClient.new }

    context 'incorrect input name' do
      let(:image)  { 'not found' }
      let(:name)   { 'huskyy' }

      it 'returns not found status' do
        allow(client).to receive(:fetch_random_image)
          .with(name)
          .and_return(image)

        response = Breed.new(name).fetch_image_url

        expect(response).to eq image
      end
    end

    context 'correct input name' do
      let(:image)  { 'https://images.dog.ceo/breeds/husky/' }
      let(:name)   { 'husky' }

      it 'returns image url' do
        allow(client).to receive(:fetch_random_image)
          .with(name)
          .and_return(image)

        response = Breed.new(name).fetch_image_url

        expect(response).to include(image)
      end
    end
  end
end
