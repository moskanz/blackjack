class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :handle_error

  def index

  end

  def handle_error
    begin
      yield             
    rescue Exception => e  
      render :error, locals: {error: e}            
    end
  end 
end
