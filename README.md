# FactoryGirlCache

`factory_girl_cache` supports to define complicated object with [factory_girl](https://github.com/thoughtbot/factory_girl)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_girl_cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory_girl_cache

## Background

If you have some factories with [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails) like this:

```ruby
FactoryGirl.define do
  factory :foo do
    name "FOO"
  end

  factory :bar do
    name: "BAR"
    association :foo, factory: :foo
  end

  factory :baz do
    name: "BAZ"
    association :foo, factory: :foo
  end
end
```

When you call `FactoryGirl.create(:bar)` and `FactoryGirl.create(:baz)` to get `bar` and `baz`, FactoryGirl creates 2 `foo` objects.
If your application cares about identity of `foo`, this is a big problem. `FactoryGirl` recommends to create them with `foo` attribute.
But it seems too difficult to pass a lot of attributes for complicated models.

## Usage

At first, place the following code into `spec/rails_helper.rb` or somewhere:

```ruby
  config.before(:each) do
    FactoryGirlCache.clear
  end
```

Second, define factories with `identifier` and `FactoryGirlCache` :

```ruby
FactoryGirl.define do
  factory :foo_1 do
    name "FOO"
  end

  factory :bar_1 do
    name: "BAR"
    foo { FactoryGirlCache.of(:foo)[1] }
  end

  factory :baz_1 do
    name: "BAZ"
    foo { FactoryGirlCache.of(:foo)[1] }
  end
end
```

The factory name referenced by `FactoryGirlCache` must be `[base_name]_[identifier]`.
`identifier` doesn't require to be `id` nor `Integer`. You can use any object to identify.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/factory_girl_cache. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FactoryGirlCache project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/akm/factory_girl_cache/blob/master/CODE_OF_CONDUCT.md).
