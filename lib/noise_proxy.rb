require 'eventmachine'
require 'json'
require 'rack'

module NoiseProxy
  root = File.expand_path('../noise_proxy', __FILE__)

  ASSET_DIR = File.join(root, 'assets')

  autoload :API,    File.join(root, 'api')
  autoload :Proxy,  File.join(root, 'proxy')
  autoload :Runner, File.join(root, 'runner')
end
