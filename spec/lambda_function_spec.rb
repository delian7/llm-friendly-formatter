require 'json'
require_relative '../lambda_function'

RSpec.describe 'LambdaFunctionSpec' do
  subject(:response) { lambda_handler(event: event, context: context) }

  let(:context) { {} }

  context 'when invoked with a valid event' do
    before do
      allow(FriendlyParser).to receive(:parse).and_return({ 'parsed_data' => 'parsed_value' })
    end

    let(:html) { '<html><body><h1>Hello, World!</h1></body></html>' }

    let(:event) do
    {
      'httpMethod' => 'POST',
      'body' => {
        'raw_html' => html
      }.to_json
    }
    end

    it 'returns a status code of 200' do
      expect(response['statusCode']).to eq(200)
    end

    it 'calls the FriendlyParser' do
      response
      expect(FriendlyParser).to have_received(:parse).with(html)
    end

    it 'returns a body that is valid JSON' do
      expect(response).to include('body')
      expect { JSON.parse(response['body']) }.not_to raise_error
    end
  end

  context 'when missing required parameters' do
    let(:event) do
      {
        'httpMethod' => 'POST',
        'body' => {
          'raw_html' => nil
        }
      }
    end

    it 'returns a status code of 405' do
      expect(response).to include('statusCode')
      expect(response['statusCode']).to eq(405)
    end
  end

  context 'when invoked with an invalid event' do
    let(:event) { { 'invalid_key' => 'unexpected data' } }


    it 'returns a status code of 405' do
      expect(response).to include('statusCode')
      expect(response['statusCode']).to eq(405)
    end

    it 'returns a body containing an error message' do
      body = JSON.parse(response['body'])
      expect(body).to include('error')
    end
  end

  context 'when an exception is raised' do
    let(:event) { nil }


    it 'returns a status code of 405' do
      expect(response).to include('statusCode')
      expect(response['statusCode']).to eq(405)
    end

    it 'returns a body with error details' do
      body = JSON.parse(response['body'])
      expect(body).to include('error')
    end
  end
end
