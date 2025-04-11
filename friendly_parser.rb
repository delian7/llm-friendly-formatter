require_relative 'html_parser'

class FriendlyParser
  def initialize(raw_html)
    @raw_html = raw_html
  end

  def parse
    HtmlParser.html_table_to_keyvalue(@raw_html)
  end
end
