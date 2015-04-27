Rails.application.config.has_files.tap do | config |

  config.attachment_options = {

    storage: :database

  }

end
