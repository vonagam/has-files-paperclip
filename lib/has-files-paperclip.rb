require 'has_files/version'
require 'has_files/has_file'
require 'has_files/concern'
require 'has_files/railtie'

ActiveRecord::Base.include HasFiles::Concern
