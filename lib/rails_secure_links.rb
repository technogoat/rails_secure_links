require "rails_secure_links/version"
ActionController::Base.send(:include, RailsSecureLinks)
::ActionView::Base.send(:include, RailsSecureLinks)

module RailsSecureLinks
  mattr_accessor :password, :server_name, :dir, :public_path, :protected_path
  @@password = :password
  @@server_name = :server_name
  @@dir = :dir
  @@public_path = :public_path
  @@protected_path = :protected_path

  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  def self.setup
    yield self
  end

  def signed_asset_url (asset_path, expire_time = (Time.now + 15.minutes).to_i)
    sanitized_asset_path = asset_path.sub(self.dir, '')

    "#{self.server_name}/#{self.public_path}/#{self.md5_calc(sanitized_asset_path, expire_time)}/#{expire_time}/#{sanitized_asset_path}"
  end

  def md5_calc (asset_path, expire_time)
    s = "#{self.password}#{expire_time}/#{self.protected_path}#{asset_path}"
    a = Base64.encode64(Digest::MD5.digest(s))
    a.tr("+/", "-_").sub('==', '').chomp
  end
end
