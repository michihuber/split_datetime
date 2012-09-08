# Split Datetime (for Rails)
Have a datetime attribute? Want to have a datepicker for the date and dropdown menus for the time?
This gem adds the necessary accessors to your model.

## Example Usage
In your `Gemfile`:

```ruby
gem "split_datetime"
```

After bundling, assuming you have an Event model with a starts_at attribute, add this to your model:

```ruby
class Event < ActiveRecord::Base
  extend SplitDatetime::Accessors
  accepts_split_datetime_for :starts_at
end
```

In your view:

```erb
<%= simple_form_for @event do |f| %>
  <%= f.input :starts_at_date, as: :string, input_html: { class: 'datepicker' } %>
  <%= f.input :starts_at_hour, collection: 0..24 %>
  <%= f.input :starts_at_min, collection: [0, 15, 30, 45] %>
  <%= ... %>
<% end %>
```

Add your js datepicker and you're good to go. (Of course, this also works with standard rails form helpers).

## Options
`starts_at` will be Time.now with the minute set to 0 by default. If you want to change this, pass in a lambda wrapping the default. E.g.:

```ruby
accepts_split_datetime_for :starts_at, default: lambda { Time.now.change(min: 0) + 2.weeks }
accepts_split_datetime_for :starts_at, default: lambda { nil }
```

You can also specify the date format for the view:

```ruby
accepts_split_datetime_for :starts_at, format: "%D"
```

See `Time#strftime` for formats. Default is `"%F"`.
