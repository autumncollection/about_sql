# encoding: UTF-8
require 'bundler'

# require lib dir
lib_dir = File.expand_path("../lib", __FILE__)
$: << lib_dir unless $:.include?(lib_dir)

::FILE_STORAGE = File.expand_path("../../data", __FILE__)
require 'app'

use Rack::Static, :urls => ['/css', '/img', '/js', '/img/maps'], :root => 'public'
use Rack::MethodOverride

run App
