if RUBY_PLATFORM == 'java'
  require 'java'
  require 'jdbc/mysql'
  Jdbc::MySQL.load_driver
else
  require 'mysql2'
end

require 'riddle'
require 'riddle/2.1.0'
require 'middleware'
require 'active_record'
require 'innertube'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module ThinkingSphinx
  MAXIMUM_STATEMENT_LENGTH = (2 ** 23) - 5

  def self.count(query = '', options = {})
    search_for_ids(query, options).total_entries
  end

  def self.facets(query = '', options = {})
    ThinkingSphinx::FacetSearch.new query, options
  end

  def self.search(query = '', options = {})
    ThinkingSphinx::Search.new query, options
  end

  def self.search_for_ids(query = '', options = {})
    search = ThinkingSphinx::Search.new query, options
    ThinkingSphinx::Search::Merger.new(search).merge! nil, :ids_only => true
  end

  def self.before_index_hooks
    @before_index_hooks
  end

  @before_index_hooks = []

  module Commands; end
  module IndexingStrategies; end
  module Interfaces; end
  module Subscribers; end
end

# Core
require 'thinking_sphinx/attribute_types'
require 'thinking_sphinx/batched_search'
require 'thinking_sphinx/callbacks'
require 'thinking_sphinx/core'
require 'thinking_sphinx/with_output'
require 'thinking_sphinx/commands/base'
require 'thinking_sphinx/commands/configure'
require 'thinking_sphinx/commands/index'
require 'thinking_sphinx/commands/start_attached'
require 'thinking_sphinx/commands/start_detached'
require 'thinking_sphinx/commands/stop'
require 'thinking_sphinx/configuration'
require 'thinking_sphinx/connection'
require 'thinking_sphinx/controller'
require 'thinking_sphinx/deletion'
require 'thinking_sphinx/errors'
require 'thinking_sphinx/excerpter'
require 'thinking_sphinx/facet'
require 'thinking_sphinx/facet_search'
require 'thinking_sphinx/float_formatter'
require 'thinking_sphinx/frameworks'
require 'thinking_sphinx/guard'
require 'thinking_sphinx/index'
require 'thinking_sphinx/indexing_strategies/all_at_once'
require 'thinking_sphinx/indexing_strategies/one_at_a_time'
require 'thinking_sphinx/index_set'
require 'thinking_sphinx/interfaces/daemon'
require 'thinking_sphinx/interfaces/real_time'
require 'thinking_sphinx/interfaces/sql'
require 'thinking_sphinx/masks'
require 'thinking_sphinx/middlewares'
require 'thinking_sphinx/panes'
require 'thinking_sphinx/query'
require 'thinking_sphinx/rake_interface'
require 'thinking_sphinx/scopes'
require 'thinking_sphinx/search'
require 'thinking_sphinx/sphinxql'
require 'thinking_sphinx/subscribers/populator_subscriber'
require 'thinking_sphinx/test'
require 'thinking_sphinx/utf8'
require 'thinking_sphinx/wildcard'
# Extended
require 'thinking_sphinx/active_record'
require 'thinking_sphinx/deltas'
require 'thinking_sphinx/distributed'
require 'thinking_sphinx/logger'
require 'thinking_sphinx/real_time'

require 'thinking_sphinx/railtie' if defined?(Rails::Railtie)
