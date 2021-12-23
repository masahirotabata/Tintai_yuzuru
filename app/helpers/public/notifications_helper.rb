module Public::NotificationsHelper

   def notification_form(notification)
      @visiter = notification.visiter
      @comment = nil
      your_real_estate = link_to 'あなたの投稿', public_customers_real_estate_path(notification), style:"font-weight: bold;"
      @visiter_comment = notification.comment_id
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "follow" then
          tag.a(notification.visiter.name, href:customers_customer_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
        # when "like" then
        #   tag.a(notification.visiter.name, href:customers_customer_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:customers_real_estate_path(notification.real_estate_id), style:"font-weight: bold;")+"にいいねしました"
        # when "comment" then
        #     @comment = Comment.find_by(id: @visiter_comment)&.content
        #     tag.a(@visiter.name, href:customers_customer_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:customers_real_estate_path(notification.real_estate_id), style:"font-weight: bold;")+"にコメントしました"
      end
    end
end   

def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
end
