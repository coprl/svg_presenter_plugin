require 'coprl/presenters/dsl/components/event_base'

module Coprl
  module Presenters
    module Plugins
      module Svg
        class Component < DSL::Components::EventBase
          DEFAULT_POSITION = :center

          attr_accessor :path,
                        :min_height,
                        :height,
                        :max_height,
                        :min_width,
                        :width,
                        :max_width,
                        :position


          def initialize(path, **attribs, &block)
            super(type: :svg, **attribs, &block)

            @path = validate_path(path)
            @min_width = validate_size(attribs.delete(:min_width))
            @width = validate_size(attribs.delete(:width))
            @max_width = validate_size(attribs.delete(:max_width))

            @min_height = validate_size(attribs.delete(:min_height))
            @height = validate_size(attribs.delete(:height))
            @max_height = validate_size(attribs.delete(:max_height))

            @position = attribs.delete(:position) { DEFAULT_POSITION }

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
