require "./lib/json_schema_generator/schema"

describe JsonSchemaGenerator::Schema do
  let(:path) { 'spec/tmp' }
  let(:pathname) { "#{path}/test.json" }

  after do
    # TODO: figure out why this doesn't work.
    `rm ./#{pathname}`
  end

  it 'creates a file in the specified path' do
    `thor json_schema_generator:schema:generate 'test' --path #{path}`
    expect(File.file?(pathname)).to be true
  end
end