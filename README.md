# Administrate::Field::AddressLatLng

Adds fields for displaying/editing latitude/longitude fields on a map to ThoughtBot's [Administrate](https://github.com/thoughtbot/administrate)

[![Gem Version](https://img.shields.io/gem/v/administrate-field-address_lat_lng.svg?style=flat)](https://rubygems.org/gems/administrate-field-address_lat_lng)
[![Build Status](https://img.shields.io/travis/fishpercolator/administrate-field-address_lat_lng/master.svg?style=flat)](https://travis-ci.org/fishpercolator/administrate-field-address_lat_lng)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate-field-address_lat_lng'
```

And then execute:

    $ bundle

## Usage

In your dashboard's `ATRRIBUTE_TYPES`, use the type `Field::AddressLatLng` with options:

```ruby
ATTRIBUTE_TYPES = {
  lat: Field::AddressLatLng,
  lng: Field::AddressLatLng,
}
```

On show pages, you will now see a map directly below the `lng` field, which shows the location on a map. On edit pages, you can click this map to change the values of `lat` and `lng` in the form.

**Important**: Your `lat` and `lng` fields must appear in the right order (`lat` first) in `SHOW_PAGE_ATTRIBUTES` and `FORM_ATTRIBUTES`. This is because each field generates a piece of the final javascript so they must be evaluated in the correct order.

If your fields are not called `lat` and `lng`, you must specify options to make it clear which is which, e.g.:

```ruby
ATTRIBUTE_TYPES = {
  latitude:  Field::AddressLatLng.with_options({lat: true}),
  longitude: Field::AddressLatLng.with_options({lng: true}),
}
```

Additional options that are available:

* `initial`: Set to an array like `[53.8003,-1.5519]`. Will cause the center of the map to be this point if the lat/lng have not yet been set (e.g. for new records). Defaults to Leeds, UK (because that's where the author is from).
* `zoom`: Set the default zoom level for maps drawn (defaults to 11).
* `search`: `true` (default) or `false`. Enable location search. Requires `google_api_key` option too.
* `google_api_key`: A [key for the Google Maps JavaScript API](https://developers.google.com/maps/documentation/javascript/get-api-key). Required for location search to work.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fishpercolator/administrate-field-address_lat_lng. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
