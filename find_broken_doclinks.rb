#!/usr/bin/env ruby
# A simple spider to check all links in the built HTML, against this local copy
# of the Flapjack documentation.
# Before running this script, start the local middleman server
# `bundle exec middleman build; bundle exec middleman server`

require 'open-uri'
require 'nokogiri'
require 'set'

LOCAL_URLS = [
  'https://github.com/flapjack/flapjack/wiki',
  'https://raw.github.com/flapjack/flapjack/wiki',
  'http://flapjack.io'
  ]

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
      if uri.start_with?('http') && !uri.include?('localhost')
        LOCAL_URLS.each { |l| links.add(uri.sub(l, 'http://0.0.0.0:4567')); break if uri.include?(l) }
        links.add(uri)
      elsif uri.start_with?('/')
        links.add("http://0.0.0.0:4567#{uri}")
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
