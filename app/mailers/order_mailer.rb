class OrderMailer < ApplicationMailer
  default from: 'no-reply@cargoapp.com'

  def order_created(order)
    @order = order
    mail(to: @order.email, subject: 'Ваша заявка принята')
  end

  def status_changed(order)
    @order = order
    mail(to: @order.email, subject: "Статус вашей заявки изменён")
  end

end
