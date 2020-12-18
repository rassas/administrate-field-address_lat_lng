$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'administrate/field/address_lat_lng'
require 'erubis'
require 'ostruct'
require 'pathname'
require 'pry'

module RenderHelpers
  
  class Content
    @@content = {}
    
    def self.set(section, content)
      @@content[section] ||= ""
      @@content[section] += content
    end
    
    def self.get(section)
      @@content[section]
    end
    
    def self.clear
      @@content = {}
    end
  end

  def root
    Pathname.new(__FILE__).dirname.dirname
  end

  # http://stackoverflow.com/a/9734736
  def hash_to_binding(hash)
    OpenStructWithHelpers.new(hash).instance_eval { binding }
  end

  # Really basic render so we don't have to include all of Rails to write
  # some specs
  def render(template, params={})
    path, tname = File.split(template)
    template = File.read(root + "app/views" + path + "_#{tname}.html.erb")
    Erubis::Eruby.new(template).result(hash_to_binding params)
  end

  def content_for(section, &block)
    Content.set(section, block.call)
  end

  def content(section)
    Content.get(section)
  end
  
  # Really rubbish object that behaves a bit like a form but doesn't output
  # correct HTML.
  def mock_form
    double.tap do |f|
      allow(f).to receive(:label)      { |*args| "LABEL: #{args}" }
      allow(f).to receive(:text_field) { |*args| "TEXT FIELD: #{args}" }
    end
  end

end

class OpenStructWithHelpers < OpenStruct
  include RenderHelpers
end

RSpec.configure do |c|
  c.include RenderHelpers
  c.before(:each) do
    RenderHelpers::Content.clear
  end
end
