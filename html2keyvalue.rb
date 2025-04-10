require 'nokogiri'
require 'optparse'

class HTML2KeyValue
  def self.html_table_to_keyvalue(html_content)
    doc = Nokogiri::HTML(html_content)
    tables = doc.css('table')

    if tables.empty?
      return "No tables found in the HTML content."
    end

    result = ""
    table_count = 0

    tables.each do |table|
      table_count += 1
      if table_count > 1
        result += "\n\n"
      end

      # Get all rows
      rows = table.css('tr')
      next if rows.empty?

      # Extract headers
      headers = rows[0].css('th, td').map { |cell| cell.text.strip }

      # Process data rows
      rows[1..-1].each_with_index do |row, row_index|
        cells = row.css('td, th').map { |cell| cell.text.strip }

        # Skip empty rows
        next if cells.empty? || cells.all?(&:empty?)

        # Add separator between records except for the first one
        result += "---\n" if row_index > 0

        # Create key-value pairs
        cells.each_with_index do |cell_text, i|
          if i < headers.length
            result += "#{headers[i]}: #{cell_text}\n"
          end
        end
      end
    end

    result
  end
end


# Parse command line options
# options = {
#   output: nil
# }

# parser = OptionParser.new do |opts|
#   opts.banner = "Usage: html2keyvalue.rb [options] [input_file]"

#   opts.on("-o", "--output FILE", "Output file (default: stdout)") do |file|
#     options[:output] = file
#   end

#   opts.on("-h", "--help", "Show this help message") do
#     puts opts
#     exit
#   end
# end

# parser.parse!

# # Read input
# if ARGV.empty?
#   html_content = STDIN.read
# else
#   html_content = File.read(ARGV[0])
# end

# # Convert to key-value format
# output = HTML2KeyValue.html_table_to_keyvalue(html_content)

# # Write output
# if options[:output]
#   File.write(options[:output], output)
# else
#   puts output
# end
