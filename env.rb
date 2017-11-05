require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

lib_dir = File.expand_path(File.dirname(__FILE__) + '/lib')
$:.unshift(lib_dir) unless $:.include?(lib_dir)