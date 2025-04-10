require 'spec_helper'
require_relative '../friendly_parser'

RSpec.describe 'FriendlyParserSpec' do
  describe '#parse' do
    let(:html) { "<html><body><h1>Hello, World!</h1></body></html>" }
    let(:parser) { FriendlyParser.new(html) }

    it "initializes with raw HTML" do
      expect(parser.instance_variable_get(:@raw_html)).to eq(html)
    end
  end
end
