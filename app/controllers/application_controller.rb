class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_filter :verify_authenticity_token, if: :json_request?

end
