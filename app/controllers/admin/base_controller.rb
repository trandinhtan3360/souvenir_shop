class Admin::BaseController < ApplicationController
  layout "admin_application"
  before_action :require_admin
end
