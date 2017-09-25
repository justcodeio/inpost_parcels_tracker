# InpostParcelsTracker

Check your parcel status and history by providing a inpost parcel tracking number

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inpost_parcels_tracker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inpost_parcels_tracker

## Usage
```ruby
Inpost::Parcel.new('111111111111111111111111').track
```
example success response :
```ruby
=> {:tracking_number=>"111111111111111111111111", :type=>"inpost_locker_standard", :custom_attributes=>{:target_machine_id=>"XXXXXX"}, :status=>"ready_to_pickup", :tracking_details=>[{:status=>"ready_to_pickup", :origin_status=>"XXX", :datetime=>"datetime"},
 {:status=>"out_for_delivery", :origin_status=>"XXX", :datetime=>"datetime"},
  {:status=>"adopted_at_source_branch", :origin_status=>"XXX", :datetime=>"datetime"},
   {:status=>"confirmed", :origin_status=>"PPN", :datetime=>"datetime"}],
    :expected_flow=>[], :created_at=>"datetime", :updated_at=>"datetime"}
```
example fail responses :

too short tracking_code provided  
```ruby
Inpost::Parcel.new('1111111111111111111').track

RuntimeError: Invalid tracking code provided
```

```ruby
Inpost::Parcel.new(nil).track

RuntimeError: Tracking code cannot be nil
```

Parcels tracking information storage gets eventually deleted from Inpost servers.
This is what eventually will be returned:
```ruby
Inpost::Parcel.new('222222222222222222222222').track
```
```ruby
=> {:status=>404, :error=>"resource_not_found", :message=>"Tracking information about 222222222222222222222222 shipment has not been found.", :details=>{}}
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/justcodeio/inpost_parcels_tracker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
