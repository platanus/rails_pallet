class Api::BaseController < ActionController::Base
  self.responder = RailsPalletResponder
  respond_to :json
end
