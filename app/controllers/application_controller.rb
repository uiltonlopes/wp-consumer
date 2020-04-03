class ApplicationController < ActionController::Base
  include Pagy::Backend
  add_breadcrumb "<a class='breadcrumb' href='/' style='margin-left: 20px;'>Home</a>".html_safe
end
