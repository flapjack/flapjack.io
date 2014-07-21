#!/usr/bin/env ruby
# A simple spider to check all links in the built HTML, against this local copy
# of the Flapjack documentation.
# Before running this script, start the local middleman server
# `bundle exec middleman build; bundle exec middleman server`

require 'open-uri'
require 'nokogiri'
require 'set'

def parse uri
  begin
    status = open(uri).status.first
    puts uri, status if !(status == '200' || status == '301')
  rescue OpenURI::HTTPError => e
    puts "Tried to open #{uri}: #{e.message}"
  end
end

def find_links uri, links
  doc = Nokogiri::HTML(uri)
  doc.css('a').each do |link|
    if link.attributes['href']
      uri = link.attributes['href'].value
      if uri.start_with?('http')
        links.add(uri) unless uri.include?('localhost')
        # FIXME: The following two conditions result in some false-positives
        # of the form http://0.0.0.0:4567/docs/0.9/support when they're actually
        # at http://0.0.0.0:4567/support
      elsif uri.start_with?('/')
        links.add("http://0.0.0.0:4567/docs/0.9#{uri}")
      elsif !uri.start_with?('#')
        links.add("http://0.0.0.0:4567/docs/0.9/#{uri}")
      end
    end
  end
end

links = Set.new

Dir.glob('build/**/*.html') do |file|
  File.open(file) do |f|
    find_links(f, links)
  end
end

links.each { |u| parse (u) }
