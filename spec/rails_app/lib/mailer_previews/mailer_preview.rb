class ActivityNotification::MailerPreview < ActionMailer::Preview

  def send_notification_email_single
    target_notification = ActivityNotification::Notification.where(group: nil).first
    ActivityNotification::Mailer.send_notification_email(target_notification)
  end

  def send_notification_email_with_group
    target_notification = ActivityNotification.config.orm == :active_record ?
      ActivityNotification::Notification.where.not(group: nil).first :
      ActivityNotification::Notification.where(:group_id.nin => ["", nil]).first
    ActivityNotification::Mailer.send_notification_email(target_notification)
  end

  def send_batch_notification_email
    target = User.find_by(name: 'Ichiro')
    target_notifications = target.notification_index_with_attributes(filtered_by_key: 'comment.default')
    ActivityNotification::Mailer.send_batch_notification_email(target, target_notifications, 'batch.comment.default')
  end

end