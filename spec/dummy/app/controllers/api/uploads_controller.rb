class Api::UploadsController < Api::BaseController
  self.responder = PaperclipUploadResponder
  respond_to :json

  def create
    respond_with PaperclipUpload::Upload.create(permitted_params), status: :created
  end

  def download
    send_file(upload.file.path, type: upload.file_content_type, disposition: 'inline')
  end

  private

  def permitted_params
    params.permit(:file)
  end

  def upload
    @upload ||= PaperclipUpload::Upload.find(params[:id])
  end
end
