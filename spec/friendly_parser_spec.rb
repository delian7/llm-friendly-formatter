require 'spec_helper'
require_relative '../friendly_parser'

RSpec.describe 'FriendlyParserSpec' do
  describe '#parse' do
    let(:html) { "<html><body><h1>Hello, World!</h1></body></html>" }
    let(:parser) { FriendlyParser.new(html) }

    it "initializes with raw HTML" do
      expect(parser.instance_variable_get(:@raw_html)).to eq(html)
    end

    context 'with the table1.html file' do
      let(:file_path) { File.join(__dir__, 'sample_inputs', 'table1.html') }
      let(:parser) { FriendlyParser.new(File.read(file_path)) }

      it "parses the HTML and extracts the table data to markdown" do
        expect(parser.parse).to include(
          "User ID: 100001",
          "First Name: John",
          "Last Name: Doe",
          "Email: john.doe@example.com",
          "Active?: Yes"
        )
      end

      it "raises an error if the file does not exist" do
        expect { FriendlyParser.new(File.read('non_existent_file.html')) }.to raise_error(Errno::ENOENT)
      end
    end

    context 'with multi line html' do
      let(:body) do
        {
          "html_content": "<table>\n  <thead>\n    <tr>\n      <th>User ID</th>\n      <th>First Name</th>\n      <th>Last Name</th>\n      <th>Email</th>\n      <th>Active?</th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr>\n      <td>100001</td>\n      <td>John</td>\n      <td>Doe</td>\n      <td>john.doe@example.com</td>\n      <td>Yes</td>\n    </tr>\n    <tr>\n      <td>100002</td>\n      <td>Jane</td>\n      <td>Smith</td>\n      <td>jane.smith@gmail.com</td>\n      <td>No</td>\n    </tr>\n    <tr>\n      <td>100003</td>\n      <td>Jim</td>\n      <td>Beam</td>\n      <td>jim.beam@yahoo.com</td>\n      <td>Yes</td>\n    </tr>\n  </tbody>\n</table>"
        }
      end

      let(:parser) { FriendlyParser.new(body[:html_content]) }

      it "parses the HTML and extracts the table data to markdown" do
        expect(parser.parse).to include(
          "User ID: 100001",
          "First Name: John",
          "Last Name: Doe",
        )
      end
    end
  end
end
