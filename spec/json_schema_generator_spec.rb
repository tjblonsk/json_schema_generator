require "spec_helper"

RSpec.describe JsonSchemaGenerator do
  it "has a version number" do
    expect(JsonSchemaGenerator::VERSION).not_to be nil
  end

  it "does something useful" do
    output = capture(:stdout) { JsonSchemaGenerator::Schema.new.generate('foo') }
    expect(output).to include 'foo'
  end
end

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end
