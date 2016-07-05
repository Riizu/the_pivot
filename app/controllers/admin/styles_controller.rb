class Admin::StylesController < Admin::BaseController

  def index
    @styles = Style.all
  end

  def edit
    @style = Style.find(params[:id])
  end

  # def update
  #   style = Style.find(params[:id])
  #   space = Space.find(style.space.id)
  #   vendor.photos.find(photo.id).update(photo_params)
  #   flash["success"] = "#{Photo.find(photo.id).title} has been updated."
  #   redirect_to platform_admin_photos_path
  # end

  # def destroy
  #   photo = Photo.find(params[:id])
  #   PhotoCategory.where(photo: photo).delete_all
  #   photo.delete
  #   flash["success"] = "#{photo.title} was successfully removed"
  #   redirect_to platform_admin_photos_path
  # end
  #
  # private
  #
  #   def photo_params
  #     params.require(:photo).permit(:title,
  #                                   :description,
  #                                   :price,
  #                                   :vendor_id,
  #                                   :image)
  #   end

end
