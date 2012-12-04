# MoverIo

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'mover_io'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mover_io

## Usage

TODO: Write usage instructions here

### Create a new session

```ruby
  config = YAML::load(File.open('config.yml'))
  mover_app_id = config['APP_ID']
  mover_app_secret = config['APP_SECRET']

  session = ::MoverIO::Session.new(:app_id => mover_app_id, :app_secret => mover_app_secret)
```

### Connections

```ruby
  session.connections.all
  => [
      #<struct MoverIO::Connector id="some_id", type="some_type">,
      #<struct MoverIO::Connector id="some_id2", type="some_type">
     ]

  session.connections.find(id)
  => #<struct MoverIO::Connector id="some_id", type="some_type">

  session.conenctions.create(type)
  => #<struct MoverIO::Connector id="some_id", type="some_type">
```

### Collections

```ruby
  connection.collections.root
  connection.collections.find(id)
  connection.collections.create(name, parent_id)
```

### Tranfers

```ruby
  session.tranfers.all
  session.transfers.create(source_connector, source_collection, destination_connector, destination_collection, options = {})
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
