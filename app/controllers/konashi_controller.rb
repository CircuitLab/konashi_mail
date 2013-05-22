class KonashiController < ApplicationController
  def mail
    KonashiMailer.help.deliver
    render :nothing => true, :status => 200
  end
end
