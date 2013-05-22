class KonashiMailer < ActionMailer::Base
  default from: "ec2-user@ip-10-121-1-171.ap-northeast-1.compute.internal"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.konashi.help.subject
  #
  def help
    @greeting = "Help me!"
    # mail to: "rei@uniba.jp"
    mail to: "daichi@uniba.jp"
  end
end
