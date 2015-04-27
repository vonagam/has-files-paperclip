require 'rails/railtie'


module HasFiles

  class Railtie < Rails::Railtie

    config.has_files = ActiveSupport::OrderedOptions.new

    config.has_files.middleware = ActiveSupport::OrderedOptions.new
    config.has_files.middleware.enabled = false
    config.has_files.middleware.route = 'files'

    config.has_files.attachment_options = {}


    initializer 'has_files.setup_model_and_middleware', group: :all do | app |

      has_files = app.config.has_files

      options = has_files.attachment_options.clone

      if has_files.middleware.enabled

        require 'has_files/middleware'

        app.config.middleware.use HasFiles::Middleware, has_files.middleware.route

        options[ :url ] = "/#{ has_files.middleware.route }/:id/:style"

      end

      HasFiles::HasFile.initialize_attachment options

    end

  end

end
