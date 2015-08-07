class UploadController < ApplicationController
  self.responder = PaperclipUploadResponder
  respond_to :json

  def create
    new_upload = PaperclipUpload::Upload.create(permitted_params)
    set_download_url(new_upload)
    respond_with new_upload, status: :created
  end

  def download
    send_file(upload.file.path, type: upload.file_content_type, disposition: 'inline')
  end

  private

  def permitted_params
    params.permit(:file)
  end

  def upload
    @upload ||= PaperclipUpload::Upload.find_by_identifier(params[:identifier])
  end

  private

  def set_download_url(_upload)
    _upload.singleton_class.send(:attr_accessor, :download_url)
    _upload.download_url = "download_link"
  end
end
