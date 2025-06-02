class OrdersController < InheritedResources::Base

  before_action :authenticate_user!

  def index
    @orders = current_user.orders

    case params[:sort]
  when 'price_asc'
    @orders = @orders.order(price: :asc)
  when 'price_desc'
    @orders = @orders.order(price: :desc)
  when 'distance_asc'
    @orders = @orders.order(distance: :asc)
  when 'distance_desc'
    @orders = @orders.order(distance: :desc)
  when 'created_at_asc'
    @orders = @orders.order(created_at: :asc)
  else
    @orders = @orders.order(created_at: :desc)
  end

  # пагинация
  @orders = @orders.page(params[:page]).per(6)
  end
  
  def create
    @order = current_user.orders.build(order_params)

    cargo = CargoCalculator.new(
      weight: @order.weight,
      length: @order.length,
      width:  @order.width,
      height: @order.height,
      from:   @order.from,
      to:     @order.to
    )

    result = cargo.result
    @order.distance = result[:distance]
    @order.price = result[:price]

    if @order.save
      SendOrderCreatedEmailJob.perform_later(@order.id)
      redirect_to @order, notice: 'Заявка успешно создана.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @order = Order.find(params[:id])

    # Если в параметрах передан статус и он отличается от текущего — вызываем событие AASM
    if params[:order][:status].present? && params[:order][:status] != @order.status
      case params[:order][:status]
      when "processing"
        @order.start_processing! if @order.may_start_processing?
      when "done"
        @order.complete! if @order.may_complete?
      when "rejected"
        @order.reject! if @order.may_reject?
      end
      redirect_to @order, notice: 'Статус заявки обновлён.'
    elsif @order.update(order_params)
      redirect_to @order, notice: 'Заявка успешно обновлена.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :middle_name, :phone, :email,
      :weight, :length, :width, :height, :from, :to
    )
  end
end
