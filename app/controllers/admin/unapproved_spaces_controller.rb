class Admin::UnapprovedSpacesController < Admin::BaseController
  def index
    @spaces = Space.where(approved: false)
  end
end
