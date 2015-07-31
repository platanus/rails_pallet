class Api::BaseController < ActionController::Base
  self.responder = PaperclipUploadResponder
  respond_to :json
end
