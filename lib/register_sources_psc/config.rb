require 'active_support'
require 'logger'
# require 'i18n'
require 'iso8601'
require 'countries'
require 'json'

require 'dotenv'
Dotenv.load('.env')

require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/try'
require 'active_support/core_ext/time'
require 'active_support/core_ext/string/conversions'
require 'active_support/core_ext/object/json'

require_relative 'version'

Time.zone='UTC'
ActiveSupport::JSON::Encoding.use_standard_json_time_format = true
ActiveSupport::JSON::Encoding.escape_html_entities_in_json = true

require 'register_sources_psc/types'

module RegisterSourcesPsc
end
