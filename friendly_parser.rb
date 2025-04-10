require_relative 'html2keyvalue'

class FriendlyParser
  def initialize(raw_html)
    @raw_html = raw_html
  end

  def parse
    HTML2KeyValue.html_table_to_keyvalue(@raw_html)
  end
end
