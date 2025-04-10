# frozen_string_literal: true

require 'json'
require_relative 'friendly_parser'

def lambda_handler(event:, context:) # rubocop:disable Lint/UnusedMethodArgument
  http_method = event['httpMethod']
  # resource = event['resource']
  # raw_data = event.dig('queryStringParameters', 'raw_data')

  case http_method
  when 'POST'
    raise StandardError, "missing request body" unless event['body']

    body = JSON.parse(event['body'])
    raise StandardError, "missing raw_html input" if body['raw_html'].nil?

    FriendlyParser.parse(body['raw_html'])
    send_response("hello from lambda!")
  else
    method_not_allowed_response
  end
rescue StandardError => e
  error_response(e)
end

def send_response(data)
  {
    'statusCode' => 200,
    'body' => JSON.generate(data)
  }
end

def method_not_allowed_response
  {
    'statusCode' => 405,
    'body' => JSON.generate({ error: 'Method Not Allowed' })
  }
end

def error_response(error)
  {
    'statusCode' => 405,
    'body' => JSON.generate({ error: error.message })
  }
end
