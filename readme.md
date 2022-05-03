# SVG Presenter Plugin

A plugin for [COPRL](http://github.com/coprl/coprl) that allows you to add inline SVG files


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'svg_presenter_plugin', git: 'https://github.com/coprl/svg_presenter_plugin', require: false
```

And then execute:

    $ bundle

## Usage

Create the Rails initializer `config/initializers/presenters_plugins.rb`
    
    Coprl::Presenters::Settings.configure do |config|
        config.presenters.plugins.push(:svg)
    end


## DSL
