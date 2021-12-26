class InquiryMailer < ApplicationMailer
    def send_mail(inquiry)
      @inquiry = inquiry
      # 追記
      mail(
        from: 'system@example.com',
        to:   ENV['TOMAIL'],
        subject: 'お問い合わせ通知'
      )
    end
end
