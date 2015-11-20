##
# Helper methods for application_controller
module ApplicationHelpers
  API_BASE_URI = 'https://kiwi-learn.herokuapp.com/'
  API_VER = '/api/v1/'

  def current_page?(path = ' ')
    path_info = request.path_info
    path_info += ' ' if path_info == '/'
    request_path = path_info.split '/'
    request_path[1] == path
  end

  def kiwi_api_url(resource)
    URI.join(API_BASE_URI, API_VER, resource).to_s
  end

  def error_send(url, msg)
    flash[:error] = msg
    redirect url
    halt 303        # http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
  end
end
