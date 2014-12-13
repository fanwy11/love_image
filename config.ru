require 'rubygems'
require 'bundler'

Bundler.require

home = File.join(File.dirname(__FILE__), 'lib')

$LOAD_PATH << home

require './main'
