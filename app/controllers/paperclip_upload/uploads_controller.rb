module PaperclipUpload
  class UploadsController < ApplicationController
    self.responder = PaperclipUploadResponder
    respond_to :json

    def show
      respond_with upload
    end

    def create
      respond_with PaperclipUpload::Upload.create(permitted_params), status: :created
    end

    private

    def permitted_params
      params.permit(:file)
    end

    def upload
      @upload ||= Upload.find(params[:id])
    end
  end
end
