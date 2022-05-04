require 'coprl/presenters/dsl/components/event_base'

module Coprl
  module Presenters
    module Plugins
      module Svg
        class Component < DSL::Components::EventBase
          attr_accessor :path, :width, :height

          def initialize(path, **attribs, &block)
            super(type: :svg, **attribs, &block)

            @path = validate_path(path)
            @width = validate_size(attribs.delete(:width))
            @height = validate_size(attribs.delete(:height))

            expand!
          end

          def render_raw_svg
            File.read(path).html_safe
          end

          private

          def full_path(path)
            Dir.pwd + "/public/#{path.delete_prefix('/')}"
          end

          def validate_path(path)
            full_file_path = full_path(path)
            unless File.exist?(full_file_path)
              raise Errors::ParameterValidation, 'There was no file found in the given path'
            end

            if File.extname(full_file_path).delete('.') == 'svg'
              full_file_path
            else
              raise Errors::ParameterValidation, 'The given file is not a svg'
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
