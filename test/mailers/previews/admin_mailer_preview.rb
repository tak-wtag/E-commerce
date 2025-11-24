# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer/pending_order_summary
  def pending_order_summary
    AdminMailer.pending_order_summary
  end
end
