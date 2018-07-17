# Ark Ruby - Crypto

<p align="center">
    <img src="https://github.com/ArkEcosystem/ruby-crypto/blob/master/banner.png" />
</p>

> A simple Ruby Cryptography Implementation for the Ark Blockchain.

[![Build Status](https://travis-ci.org/ArkEcosystem/ruby-crypto.svg?branch=develop)](https://travis-ci.org/ArkEcosystem/ruby-crypto)
[![Latest Version](https://img.shields.io/github/release/ArkEcosystem/ruby-crypto.svg?style=flat-square)](https://github.com/ArkEcosystem/ruby-crypto/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Installation

## Bundler

Add this line to your application's Gemfile:

```ruby
gem 'arkecosystem-crypto'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arkecosystem-crypto

## Documentation

Have a look at the [official documentation](https://docs.ark.io/v1.0/docs/cryptography-ruby) for advanced examples and features.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, copy and edit the contents of the `.env.example` file into a file called `.env`. This file represents your network and account details. You can then run the tests using `rake spec`. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Security

If you discover a security vulnerability within this package, please send an e-mail to security@ark.io. All security vulnerabilities will be promptly addressed.

## Credits

- [Brian Faust](https://github.com/faustbrian)
- [Christopher Wang](https://github.com/christopherjwang) **Initial Cryptography Implementation**
- [All Contributors](../../../../contributors)

## License

[MIT](LICENSE) © [ArkEcosystem](https://ark.io)
