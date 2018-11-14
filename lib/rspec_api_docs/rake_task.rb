require 'rake'
require 'rspec'
require 'json'
require 'rspec_api_docs/config'

module RspecApiDocs
  class RakeTask < ::Rake::TaskLib
    module RSpecMatchers
      extend RSpec::Matchers
    end

    attr_accessor \
      :verbose,
      :pattern,
      :rspec_opts,
      :existing_file,
      :verify

    def initialize(name = nil, &block)
      @name = name
      @verbose = true
      @pattern = 'spec/requests/**/*_spec.rb'
      @rspec_opts = []
      @existing_file = 'docs/index.json'
      @verify = false

      block.call(self) if block

      define
    end

    private

    def define
      desc default_desc
      task name do
        verify ? verify_api_docs : generate_api_docs(rspec_task_options)
      end
    end

    def verify_api_docs
      Dir.mktmpdir do |tmp_dir|
        task_options = rspec_task_options
        task_options << ["--require #{tmp_output_dir_config(tmp_dir).path}"]

        generate_api_docs(task_options)

        generated_api_docs = read_json(File.join(tmp_dir, 'index.json'))
        existing_api_docs = read_json(existing_file)
        verify!(generated_api_docs, existing_api_docs)
      end
    end

    def generate_api_docs(options = [])
      rspec_task(options).run_task(verbose)
    end

    def read_json(path)
      JSON.parse(File.read(path))
    end

    def rspec_task(rspec_opts)
      RSpec::Core::RakeTask.new.tap do |task|
        task.pattern = pattern
        task.rspec_opts = rspec_opts
      end
    end

    def tmp_output_dir_config(tmp_dir)
      tempfile = Tempfile.new(['tmp_config', '.rb' ])
      tempfile.write <<-EOF
        require "rspec_api_docs"
        RspecApiDocs.configure do |config|
          config.output_dir = '#{tmp_dir}'
        end
      EOF
      tempfile.close
      tempfile
    end

    def configure_rspec
      RSpec.configure do |config|
        config.color = true
      end
    end

    def verify!(generated_api_docs, existing_api_docs)
      configure_rspec
      RSpecMatchers.expect(generated_api_docs).to RSpecMatchers.eq(existing_api_docs)
    end

    def rspec_task_options
      rspec_opts + [
        '--format RspecApiDocs::Formatter',
        '--order defined',
      ]
    end

    def name
      @name ||
        verify ? :'docs:ensure_updated' : :'docs:generate'
    end

    def default_desc
      verify ? 'Ensure API docs are up to date' : 'Generate API docs'
    end
  end
end
