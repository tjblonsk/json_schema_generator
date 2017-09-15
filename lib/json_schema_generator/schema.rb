require "thor"

module JsonSchemaGenerator
  class Schema < Thor
    desc "Generate model schema", "Generate a json schema scaffold for the supplied model."
    def generate(name)
      puts name
      stdout
    end
  end
end
