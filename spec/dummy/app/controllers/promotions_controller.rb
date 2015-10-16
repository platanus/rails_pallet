class PromotionsController < ApplicationController
  def example
    promo
  end

  def update
    promo.update_attributes(permitted_params)
    redirect_to action: 'example'
  end

  def download
    send_file(promo.photo.path, type: promo.photo_content_type, disposition: 'inline')
  end

  private

  def promo
    @promotion ||= Promotion.first_or_create
  end

  def permitted_params
    params.require(:promotion).permit(:upload_identifier, :encoded_photo, :photo)
  end
end
