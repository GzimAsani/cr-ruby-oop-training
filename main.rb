#!/usr/bin/env ruby
require_relative './lib/work'

def main
  app = App.new
  puts "Welcome to school library app \n\n"
  response = nil

  while response != '7'
    options
    response = gets.chomp

    dispatch(response, app)
  end
end

main
