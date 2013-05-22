class KonashiController < ApplicationController
  def help
    KonashiMailer.help.deliver
    render :nothing => true, :status => 200
  end
end
