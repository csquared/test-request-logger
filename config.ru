require 'bundler'
Bundler.require
require 'sinatra/base'

#use Rack::CgiProxy, ENV['REQUEST_LOGGER_URL']

class RequestIntrospector < Sinatra::Base
  # show ALL the methods!
  %w{get post put delete head}.each do |http_method|
    eval <<-RUBY
      #{http_method} '*' do
        resp = "HTTP Method: #{http_method.upcase}\n"  + 
        "Params:      \#{params.inspect}\n" + 
        "Headers:     \#{headers.inspect}\n" +  
        "Request:     \#{request.inspect}" 
        content_type 'text/plain'
        resp
      end
    RUBY
  end
end

# drop it like its hot
run RequestIntrospector
