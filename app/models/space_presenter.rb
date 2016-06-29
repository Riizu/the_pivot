class SpacePresenter
  attr_reader :template

  def initialize(space, template)
    @space = space
    @template = template
  end

  # def approved
  #   if @space.approved
  #     "This space is currently unavailable"
  #   else
  #     template.button_to("Reserve this Space", "/cart_spaces",
  #                        params: { space_id: @space.id }, class: "btn btn-custom btn-person")
  #   end
  # end
end
