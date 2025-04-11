require 'rspec'
require_relative '../html_parser.rb'

RSpec.describe HtmlParser do
  let(:table1_html) { File.read(File.join(File.dirname(__FILE__), 'sample_inputs', 'table1.html')) }
  let(:table1_md) { File.read(File.join(File.dirname(__FILE__), 'sample_outputs', 'table1.md')) }

  let(:table2_html) { File.read(File.join(File.dirname(__FILE__), 'sample_inputs', 'table2.html')) }
  let(:table2_md) { File.read(File.join(File.dirname(__FILE__), 'sample_outputs', 'table2.md')) }

  let(:table3_html) { File.read(File.join(File.dirname(__FILE__), 'sample_inputs', 'table3.html')) }

  describe '.html_table_to_keyvalue' do
    # it 'correctly converts table2 HTML to markdown' do
    #   result = described_class.html_table_to_keyvalue(table2_html)
    #   expect(result.strip).to eq(table2_md.strip)
    # end

    # it 'handles table3 HTML without errors' do
    #   expect { described_class.html_table_to_keyvalue(table3_html) }.not_to raise_error
    # end

    it 'returns a non-empty string for table3 HTML' do
      result = described_class.html_table_to_keyvalue(table3_html)
      expect(result.strip).not_to be_empty
    end
  end
end
