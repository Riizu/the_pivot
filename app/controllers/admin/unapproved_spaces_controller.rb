class Admin::UnapprovedSpacesController < Admin::BaseController
  def index
    @spaces = Space.where(approved: false)
  end

  def update
    @space = Space.find(params[:id])
    @space.approve
    flash[:success] = "Space was successfully approved!"
    redirect_to admin_unapproved_spaces_path
  end
end
