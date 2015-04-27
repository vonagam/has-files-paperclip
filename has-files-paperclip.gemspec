# coding: utf-8

lib = File.expand_path( '../lib', __FILE__ )
$LOAD_PATH.unshift( lib ) unless $LOAD_PATH.include?( lib )
require 'has_files/version'

Gem::Specification.new do | spec |

  spec.name          = 'has-files-paperclip'
  spec.version       = HasFiles::VERSION
  spec.authors       = [ 'Dmitry Maganov' ]
  spec.email         = [ 'vonagam@gmail.com' ]
  spec.summary       = 'Singular and plural file attachments as easy as usual model relations.'
  spec.description   = '"has_file" and "has_files" helpers for ActiveRecord: polymorphic association with support for adjustable styles and validations.'
  spec.homepage      = 'https://github.com/vonagam/has-files-paperclip'
  spec.license       = 'MIT'

  spec.files         = Dir[
    'lib/**/*',
    'README.md',
    'LICENSE.txt'
  ]
  spec.require_paths = [ 'lib' ]


  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'combustion'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-rails'
  spec.add_development_dependency 'pry-rescue'
  spec.add_development_dependency 'pry-stack_explorer'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'factory_girl_rails'

  spec.add_dependency 'rails'
  spec.add_dependency 'paperclip'

end
