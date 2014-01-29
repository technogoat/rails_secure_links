RailsSecureLinks.setup do |config|
  config.password = 'SOOPER_SECRET_PASSWORD'
  config.server_name = '' # example: http://localhost:3000
  config.dir = '' # private file system storage path, example /mnt/data/uploads
  config.public_path = '' # nginx public asset path
  config.protected_path = '' # nginx internal protected path
end
