[![Build Status](https://travis-ci.org/codepr/lingua-it-readability.svg?branch=master)](https://travis-ci.org/codepr/lingua-it-readability)
[![Gem Version](https://badge.fury.io/rb/lingua-it-readability.svg)](https://badge.fury.io/rb/lingua-it-readability)

# Lingua::It::Readability

Inpired by Lingua::EN::Readability and his perl original version Lingua::EN::Fathom, a gem focused on readability of Italian language texts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lingua-it-readability'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lingua-it-readability

## Usage

```ruby
require 'lingua/it/readability'

text   = 'Testo campione da analizzare con Gulpease e Flesch tarati su lingua Italiana.'
report = Lingua::IT::Readability.new(text)
report.num_sentences # 1
report.num_words     # 12
report.num_syllables # 29
report.syllables     # array containing all 29 syllables => ['Te', 'sto', 'cam', 'pio', 'ne', ... ,]
report.sentences     # array containing all sentences => [...]
report.words         # array containing all words => ['Testo', 'campione', 'da', 'analizzare', ... ,]
report.gulpease      # 59
report.flesch        # 36.92
report.report        # a formatted summary of statistics and measures

# accept custom symbols as delimiters
text = "Lista:\n- Gennaio;\n- Febbraio;"
report = Lingua::IT::Readability.new(text, ':', '-')
report.num_sentences # 3
report.num_words     # 3
report.num_syllables # 8
report.report        # a formatted summary of statistics and measures

# It's also possible to not directly initialize the object..
text = "Lista:\n- Gennaio;\n- Febbraio;"
report = Lingua::IT::Readability.new
# ..using method analyze with optional delimiters
report.analyze(text, ':', ';')
report.num_sentences # 3
report.num_words     # 3
report.num_syllables # 8
report.report        # a formatted summary of statistics and measures
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Changelog

See the [CHANGELOG](CHANGELOG.md) file.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/codepr/lingua-it-readability.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
