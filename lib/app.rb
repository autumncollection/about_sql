# encoding : utf-8
require 'bundler/setup'
require 'sinatra'
require 'sinatra/namespace'
require 'sass'
require 'database'

class App < Sinatra::Application

  set :slim, :pretty => true
  set :root, File.dirname(__FILE__)
  set :layout, :'views/layouts/application'
  set :public_folder, 'public'

  configure :development do
    log = File.new('log/std.log', 'a')
    $stdout.reopen(log)
    $stderr.reopen(log)
    STDOUT.sync = true
    STDERR.sync = true
  end

end

