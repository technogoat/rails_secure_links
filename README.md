# Rails Secure Links

Simple Ruby on Rails gem that takes advantage of the nginx secure_link module (http://nginx.org/en/docs/http/ngx_http_secure_link_module.html) in order to secure your uploaded assets from unauthorized access. Inspired by this gist: https://gist.github.com/mikhailov/3174601

## Installation

Add this line to your application's Gemfile:

    gem 'rails_secure_links'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_secure_links

Run the generator

    $ rails g rails_secure_links

It will generate config/initializers/secure_links.rb

    RailsSecureLinks.setup do |config|
      config.password = 'SOOPER_SECRET_PASSWORD'
      config.server_name = '' # example: http://localhost:3000
      config.dir = '' # private file system storage path, example /mnt/data/uploads
      config.public_path = '' # nginx public asset path
      config.protected_path = '' # nginx internal protected path
    end

Assuming you've compiled nginx with all the required modules as described here: https://gist.github.com/mikhailov/3174601 configure your nginx like this:

    server {
      listen 80;
      server_name example.com;
      root /home/rails/apps/example_app/current/public;
      passenger_enabled on;

        location /public_path/ {
                rewrite /public_path/([a-zA-Z0-9_\-]*)/([0-9]*)/(.*)$ /protected_path/$3?st=$1&e=$2;
        }

        location /protected_path/ {
                internal;
                secure_link $arg_st,$arg_e;
                secure_link_md5 SOOPER_SECRET_PASSWORD$arg_e$uri;

                if ($secure_link = "") { return 403; }
                if ($secure_link = "0") { return 403; }

                root /mnt/data;

                add_header Cache-Control 'private, max-age=0, must-revalidate';
                add_header Strict-Transport-Security "max-age=16070400; includeSubdomains";
                add_header X-Frame-Options DENY;
        }
    }

## Usage

In your views, controllers or helpers use:

    signed_asset_url(Asset.first.file.path, 30.minutes.from_now.to_i)

## Contributing

1. Fork it ( http://github.com/technogoat/rails_secure_links/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
