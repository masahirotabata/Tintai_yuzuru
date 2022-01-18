class Public::InquiryController < ApplicationController
    def new
        @inquiry = Inquiry.new
    end
    def create
        @inquiry = Inquiry.new(inquiry_params)
        if @inquiry.save
            InquiryMailer.send_mail(@inquiry).deliver_now
            redirect_to root_path
        else
            render :new
        end
    end
    
    private
    def inquiry_params
        params.require(:inquiry).permit(:name,:message)
    end
end
