require_relative 'svg/component'

module Coprl
  module Presenters
    module Plugins
      module Svg
        module DSLComponents

          def svg(path, **attributes, &block)
            self << Svg::Component.new(path, parent: self, **attributes, &block)
          end

        end

        module WebClientComponents
          def view_dir_svg(pom)
            File.join(__dir__, '../../../..', 'views', 'components')
          end

          def render_header_svg(pom, render:)
            render.call :erb, :svg_header, views: view_dir_svg(pom)
          end

          def render_svg(comp, render:, components:, index:)
            render.call :erb, :svg, views: view_dir_svg(comp),
                        locals: {comp: comp,
                                 components: components,
                                 index: index}
          end

        end
      end
    end
  end
end
