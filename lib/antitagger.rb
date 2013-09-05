require 'nokogiri'

class Antitagger
  
  attr_accessor :file_name, :tags, :wrap_tag, :doc
  
  # Initialize with the file name, and the list of tags to check for (splat array).
  def initialize(file_name, *tags)
    @file_name = file_name
    @tags = tags.map{|tag| "/tag/#{tag}" }
    @wrap_tag = "html"
  end
  
  # Strip out HREFs which contain a given tag and return the 
  def untag!
    parse
    @tags.each do |tag|
      @doc.xpath("//a[contains(@href,'#{tag}')]").each do |element|
        element.swap(element.children)
      end
    end
    @doc.xpath("/#{@wrap_tag}").inner_html
  end
  
  # Open the file from the filename and parse it with Nokogiri into an XML document
  # Rescue parser exceptions and log them, then close the file
  def parse
    file = File.open(@file_name)
    @doc = Nokogiri::XML(wrap(file.readlines)) do |config|
      config.strict
    end
  rescue
    log("Error parsing file #{@file_name}, couldn't continue. Probably faulty HTML")
  ensure
    file.close
  end
  
  
  private
  
  # Need to wrap the text in an outer tag so that Nokogiri will read it
  def wrap(content)
    ["<#{@wrap_tag}>", content, "</#{@wrap_tag}>"].join
  end
  
  # Log to somewhere
  def log(message)
    puts message
  end
  
end