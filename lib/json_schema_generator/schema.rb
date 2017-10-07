require "thor"

module JsonSchemaGenerator
  class Schema < Thor
    desc "Generate MODEL_SCHEMA", "Generate a json schema scaffold for the supplied model."
    option :path
    # DEFAULT_PATH = 'app/schemas/<model_name>/model_name.json'
    DEFAULT_PATH = 'app/schemas'
    def generate(model_name)
      path = options[:path] || DEFAULT_PATH
      system 'mkdir', '-p', path

      File.open("#{path}/#{model_name}.json", "w") do |f|
        f.write(template(model_name))
      end
    end

    private

    # TODO: use this strategy: https://git.xogrp.com/Shared/xo_wedding/blob/develop/lib/generators/xo_wedding/config_generator.rb
    def template(model_name)
      <<~HEREDOC
        {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "type": "object",
          "properties": {}
        }
      HEREDOC
    end
  end
end
