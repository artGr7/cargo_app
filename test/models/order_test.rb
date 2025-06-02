require "test_helper"

class OrderTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper
  test "valid order" do
    order = Order.new(
      first_name: "Иван",
      last_name: "Иванов",
      middle_name: "Иванович",
      phone: "+79001234567",
      email: "ivan@example.com",
      weight: 5,
      length: 50,
      width: 50,
      height: 50,
      from: "Moscow",
      to: "Kazan",
      user: users(:one)
    )

    assert order.valid?
  end

  test "invalid without required fields" do
    order = Order.new
    assert_not order.valid?
    assert_includes order.errors[:first_name], "can't be blank"
  end

  test "order belongs to user" do
    user = users(:one)
    order = user.orders.create!(
      first_name: "John", last_name: "Doe", middle_name: "M", phone: "+79441234567", email: "john@example.com",
      weight: 5, length: 10, width: 10, height: 10, from: "Moscow", to: "Kazan"
    )
    assert_equal user.id, order.user_id
  end

  test "order status transitions work" do
    order = orders(:one)
    assert_equal "new", order.status
    order.start_processing!
    assert_equal "processing", order.status
    order.complete!
    assert_equal "done", order.status
  end

end
