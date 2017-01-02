require 'rspec_api_docs/config'
require 'rspec_api_docs/version'

# The base module of the gem.
module RspecApiDocs
  METADATA_NAMESPACE = :rspec_api_docs

  BaseError = Class.new(StandardError)
end
