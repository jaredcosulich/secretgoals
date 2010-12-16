class Admin::EmailsController < AdminController

  def index
  end

  def show
    if params[:args].blank?
      email = Mailer.send(params[:id], User.first.id, fake_emailing)
    else
      email = Mailer.send(params[:id], User.first.id, fake_emailing, *params[:args])
    end
    render :text => email.body
  end

  private
  def fake_emailing
    FakeEmailing.new
  end

  class FakeEmailing
    def auto_login_url(path)
      path
    end
  end

end
