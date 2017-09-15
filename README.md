# JsonSchemaGenerator

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/json_schema_generator`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_schema_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_schema_generator

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_schema_generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JsonSchemaGenerator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/json_schema_generator/blob/master/CODE_OF_CONDUCT.md).


TODO

v1
rake generate_json_schema <model_name>
- app/schemas/<model_name>/model_name.json
  {
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {}
  }
- app/schemas/<model_name>/schema.rb
  class Schema
    def contents
      json_string = File.read("#{Rails.root}/config/schemas/<model_name>/schema.json")
      JSON.parse(json_string)
    end

    def self.load
      ::ModelNameJsonSchema ||= self.new.contents
    end
  end

- spec/schemas/<model_name>/schema_spec.rb
  require 'rails_helper'

  describe 'Wedding Upsert Schema' do
    def validate_json(param_additions)
      JSON::Validator.fully_validate(ModelNameSchema.load, required_params.merge(param_additions))
    end

    it 'has no errors using the base required parameters' do
      errors = validate_json({})
      expect(errors.length).to eq(0)
    end
  end

    ## Example tests

      it 'will accept wedding date and engagment date in the format YYYY-mm-dd' do
        errors = validate_json(wedding_date: '2017-08-20', engagment_date: '2016-08-20')
        expect(errors.length).to eq(0)
      end

      it 'does not accept wedding date or engagement date in formats other than YYYY-mm-dd' do
        errors = validate_json(wedding_date: '08/20/2017', engagement_date: '08/20/2016')
        expect(errors.length).to eq(4)
      end

      it 'does not accept wedding or engagement dates that are not a valid date' do
        errors = validate_json(wedding_date: '2017-08-50', engagment_date: '2016-08-50')

        expect(errors.length).to eq(1)
        expect(errors.first).to include('must be a valid date')
      end

  end

- ModelNameController
  before_action :validate_payload, only: [:create, :update]

  private

  def validate_upsert_payload
    errors = JSON::Validator.fully_validate(WeddingSchema.load,
                                            WeddingParams.params_for_validation(params))

    unless errors.empty?
      errors << 'Please visit the API docs for a full reference.'
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

v2

- add flags for required
- generate callback for controller in separate command
- rake <model_name> add_string <field_name> <string ops>
- rake <model_name> add_numberic <field_name> <numberic ops>

v3

- add object and array support:
  rake <model_name> add_object <field_name> <object ops>
  rake <model_name> add_array <field_name> <array ops>


v4
  - on rake <model_name> generate_json_schema, look up model column names in DB and build initial properties
