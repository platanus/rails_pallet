class UploadController < ApplicationController
  self.responder = PaperclipUploadResponder
  respond_to :json

  def create
    new_upload = PaperclipUpload::Upload.create(permitted_params)
    respond_with new_upload, status: :created
  end

  private

  def permitted_params
    params.permit(:file)
  end

  def upload
    @upload ||= PaperclipUpload::Upload.find_by_identifier(params[:identifier])
  end
end
