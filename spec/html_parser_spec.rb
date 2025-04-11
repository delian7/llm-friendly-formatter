require 'rspec'
require_relative '../html_parser.rb'

RSpec.describe HtmlParser do
  let(:table1_html) { File.read(File.join(File.dirname(__FILE__), 'sample_inputs', 'table1.html')) }
  let(:table1_md) { File.read(File.join(File.dirname(__FILE__), 'sample_outputs', 'table1.md')) }

  let(:table2_html) { File.read(File.join(File.dirname(__FILE__), 'sample_inputs', 'table2.html')) }
  let(:table2_md) { File.read(File.join(File.dirname(__FILE__), 'sample_outputs', 'table2.md')) }

  let(:table3_html) { File.read(File.join(File.dirname(__FILE__), 'sample_inputs', 'table3.html')) }

  describe '.html_table_to_keyvalue' do
    it 'correctly converts table1 HTML to markdown' do
      result = described_class.html_table_to_keyvalue(table1_html)
      expect(result).to include("User ID: 100001")
      expect(result).to include("First Name: John")
      expect(result).to include("Last Name: Doe")
      expect(result).to include("Email: john.doe@example.com")
      expect(result).to include("Active?: Yes")
    end

    it 'correctly converts table2 HTML to markdown' do
      result = described_class.html_table_to_keyvalue(table2_html)
      expect(result).to include("SYMBOL: 1")
      expect(result).to include("LOCATION: FRONT BEDROOM")
      expect(result).to include("NOMINAL SIZE, WIDTH: 2' - 6\"")
      expect(result).to include("NOMINAL SIZE, HEIGHT: 4' - 0\"")
      expect(result).to include("TYPE: L.H. CASM'T")
      expect(result).to include("TYPE: A")
      expect(result).to include("HEAD HEIGHT: 6' - 8\"")
      expect(result).to include("GLAZING, GLASS TYPE: DBL")
      expect(result).to include("GLAZING, SAFETY:")
      expect(result).to include("SCREEN: Y")
      expect(result).to include("HARDWARE:")
      expect(result).to include("EGRESS: Y")
      expect(result).to include("MANUFACTURE:")
      expect(result).to include("NOTES: SEE ELEVATIONS")
    end

    it 'handles table3 HTML without errors' do
      expect { described_class.html_table_to_keyvalue(table3_html) }.not_to raise_error
    end

    it 'returns a non-empty string for table3 HTML' do
      result = described_class.html_table_to_keyvalue(table3_html)
      expect(result.strip).not_to be_empty
    end
  end
end
