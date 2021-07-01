class User::InquiriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @inquiry = Inquiry.new
  end


  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver
      redirect_to new_inquiry_path
      flash[:email] = "お問い合わせが完了しました"
    else
      render 'new'
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
