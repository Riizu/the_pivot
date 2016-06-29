class SockPresenter
  attr_reader :template

  def initialize(space, template)
    @space = space
    @template = template
  end

  def retired
    if @space.retired
      "Item Retired"
    else
      template.button_to("Add to Cart", "/cart_spaces",
                         params: { space_id: @space.id }, class: "btn btn-custom btn-person")
    end
  end
end
