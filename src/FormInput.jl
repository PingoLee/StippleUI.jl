module FormInput

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, template

export textfield, numberfield, textarea, filefield

Genie.Renderer.Html.register_normal_element("q__input", context = @__MODULE__)
Genie.Renderer.Html.register_normal_element("q__file", context = @__MODULE__)

function textfield( label::String = "",
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)
  wrap() do
    q__input(args...; attributes([:label => label, :fieldname => fieldname, kwargs...], StippleUI.API.ATTRIBUTES_MAPPINGS)...)
  end
end


function numberfield( label::String = "",
                      fieldname::Union{Symbol,Nothing} = nothing,
                      args...;
                      wrap::Function = StippleUI.DEFAULT_WRAPPER,
                      kwargs...)
    textfield(label, nothing, args...;  attributes(
                          [:fieldname => fieldname, :wrap => wrap, :type => "number", kwargs...],
                          Dict("fieldname" => "v-model.number")
                        )...)
end

function textarea(label::String = "",
                  fieldname::Union{Symbol,Nothing} = nothing,
                  args...;
                  wrap::Function = StippleUI.DEFAULT_WRAPPER,
                  kwargs...)

  textfield(label, fieldname, args...; type="textarea", wrap=wrap, kwargs...)
end

function filefield( label::String = "",
                    fieldname::Union{Symbol,Nothing} = nothing,
                    args...;
                    wrap::Function = StippleUI.DEFAULT_WRAPPER,
                    kwargs...)

  wrap() do
    q__file(args...; attributes(
                        [:label => label, :fieldname => fieldname, kwargs...],
                        Dict("fieldname" => "v-model",
                              "itemaligned" => "item-aligned", "stacklabel" => "stack-label", "bottomslots" => "bottom-slots",
                              "hidebottomspace" => "hide-bottom-space", "hidehint" => "hide-hint", "displayvalue" => "display-value",
                              "reactiverules" => "reactive-rules", "lazyrules" => "lazy-rules", "rules" => ":rules",
                              "counterlabel" => "counter-label", "maxfiles" => "max-files", "maxtotalsize" => "max-total-size", "maxfilesize" => "max-file-size",
                              "errormessage" => "error-message", "noerroricon" => "no-error-icon", "clearicon" => "clear-icon",
                              "inputstyle" => "input-style", "inputclass" => "input-class", "bgcolor" => "bg-color",
                              "labelslot" => "label-slot", "labelcolor" => "label-color"
                              )
                      )...)
  end
end

end
