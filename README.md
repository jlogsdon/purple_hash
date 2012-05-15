Purple Hash is a configuration library for ruby that builds upon Ruby's core
Hash. At it's core Purple allows you to access keys that do not exist yet by
defining a default value proc which provides you with a new instance of a
Purple Hash. Keys are also normalized to symbols, similar to how Rail's
`HashWithIndifferentAccess` works.

```ruby
require 'purple_hash'

config = PurpleHash.new
config[:db]['user'] = 'root'
config # => {:db => {:user => 'root'}}

config = PurpleHash.new(:db => {'user' => 'root'})
config # => {:db => {:user => 'root'}}
```

Because a `PurpleHash` is simply a sub-class of `Hash` you can do anything you
would normally be able to without any hacks or tricks. A core extension of Hash
is provided if you wish to use it, simply require `core_ext/hash/purple_hash`
and call `#to_purple_hash` on any Ruby hash to get a `PurpleHash` back.

**Note:** If you try to change the default value on a `PurpleHash` a `RuntimeError`
will be raised informing you that this is not allowed.

## API

`PurpleHash` provides a very basic API on top of what Hash already provides.

### `#configure_from_hash(hash)`

Takes a raw `Hash` and converts itself and any nested hashes to a `PurpleHash`.
Used internally by `#initialize`

### `#freeze!`

Locks the hash from any futher modifications. A `PurpleHash::HashFrozen` will be
raised if the hash is frozen and you attempt to modify it. Keys that are not
already defined will return `nil` instead of a new `PurpleHash`.

### `#frozen?`

Find out if the hash is frozen.
