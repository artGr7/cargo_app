require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference("Order.count") do
      post orders_url, params: { order: { 
        email: @order.email,
        first_name: @order.first_name,
        from: @order.from,
        height: @order.height,
        last_name: @order.last_name,
        length: @order.length,
        middle_name: @order.middle_name,
        phone: @order.phone,
        to: @order.to,
        weight: @order.weight,
        width: @order.width
      } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { 
      distance: @order.distance,
      email: @order.email,
      first_name: @order.first_name,
      from: @order.from,
      height: @order.height,
      last_name: @order.last_name,
      length: @order.length,
      middle_name: @order.middle_name,
      phone: @order.phone,
      to: @order.to,
      weight: @order.weight,
      width: @order.width
    } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference("Order.count", -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
    
  end
  
  test "should redirect orders index if not logged in" do
    sign_out @user
    get orders_url
    assert_redirected_to new_user_session_path
  end  

  test "should get orders index if logged in" do
    get orders_url
    assert_response :success
  end
  
  test "email is sent after creating order" do
    user = users(:one)
    sign_in user

    assert_enqueued_with(job: SendOrderCreatedEmailJob) do
      post orders_url, params: {
        order: {
          first_name: "Test", last_name: "User", middle_name: "M", phone: "+79001233567", email: user.email,
          weight: 1, length: 10, width: 10, height: 10, from: "Moscow", to: "Kazan"
        }
      }
    end
  end

  test "email is sent after status change" do
    order = orders(:one)
    assert_enqueued_with(job: SendStatusChangedEmailJob) do
      patch order_url(order), params: { order: { status: "processing" } }
      order.reload
    end
  end

end
