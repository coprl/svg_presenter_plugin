require 'coprl/presenters/dsl/components/event_base'

module Coprl
  module Presenters
    module Plugins
      module Svg
        class Component < DSL::Components::EventBase
          attr_accessor :path, :width, :height

          def initialize(path, **attribs, &block)
            super(type: :svg, **attribs, &block)

            @path = path
            @width = validate_size(attribs.delete(:width))
            @height = validate_size(attribs.delete(:height))
            expand!
          end

          def full_path
            Dir.pwd + "/public/#{path.delete_prefix('/')}"
          end

          def render_raw_svg
            if File.exists?(full_path)
              File.read(full_path).html_safe
            end
          end

          # Ensure all size values have a unit, defaulting to pixels.
          def validate_size(value)
            return unless value
            return "#{value}px" if value.to_s.match?(/\A\d+\Z/)

            value
          end
        end
      end
    end
  end
end
