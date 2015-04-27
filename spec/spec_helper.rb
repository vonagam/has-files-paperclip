require 'pry'
require 'pry-rescue'
require 'pry-stack_explorer'
require 'pry-rails'
require 'database_cleaner'
require 'combustion'
require 'factory_girl_rails'
require 'support'

Combustion.initialize! :active_record

require 'factories'

SPECS_PATH = Pathname.new( __FILE__ ).dirname


RSpec.configure do | config |

  config.include FactoryGirl::Syntax::Methods

  
  config.before :suite do

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation

  end

  config.around :each do | example |

    DatabaseCleaner.cleaning do

      example.run

    end

  end
  
end
