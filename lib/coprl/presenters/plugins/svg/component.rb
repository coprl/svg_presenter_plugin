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
            @width = attribs.delete(:width)
            @height = attribs.delete(:height)
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

        end
      end
    end
  end
end
