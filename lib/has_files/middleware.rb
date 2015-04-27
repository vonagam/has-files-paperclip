module HasFiles

  class Middleware

    def initialize ( app, route )

      @app = app

      @route = /\/#{ route }/

    end

    def call ( env )

      if attachment_request? env

        send_attachment env

      else

        @app.call env

      end

    end

    private

    def attachment_request? ( env )

      env[ 'PATH_INFO' ] =~ @route

    end

    def send_attachment ( env )

      path = env[ 'PATH_INFO' ].split( '/' )

      id = path[ 2 ]

      model = HasFiles::HasFile.find id

      headers = {

        'Content-Type' => model.attachment_content_type,
        'Cache-Control' => 'public, max-age=31536000',
        'Last-Modified' => model.attachment_updated_at.httpdate

      }

      if headers[ 'Last-Modified' ] == env[ 'HTTP_IF_MODIFIED_SINCE' ]

        [ 304, headers, [] ]

      else

        style = path[ 3 ]

        attachment = model.attachment

        [ 200, headers, [ attachment.file_contents( style ) ] ]

      end

    end

  end

end
