require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Distance", with: @order.distance
    fill_in "Email", with: @order.email
    fill_in "First name", with: @order.first_name
    fill_in "From", with: @order.from
    fill_in "Height", with: @order.height
    fill_in "Last name", with: @order.last_name
    fill_in "Length", with: @order.length
    fill_in "Middle name", with: @order.middle_name
    fill_in "Phone", with: @order.phone
    fill_in "Price", with: @order.price
    fill_in "To", with: @order.to
    fill_in "Weight", with: @order.weight
    fill_in "Width", with: @order.width
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Distance", with: @order.distance
    fill_in "Email", with: @order.email
    fill_in "First name", with: @order.first_name
    fill_in "From", with: @order.from
    fill_in "Height", with: @order.height
    fill_in "Last name", with: @order.last_name
    fill_in "Length", with: @order.length
    fill_in "Middle name", with: @order.middle_name
    fill_in "Phone", with: @order.phone
    fill_in "Price", with: @order.price
    fill_in "To", with: @order.to
    fill_in "Weight", with: @order.weight
    fill_in "Width", with: @order.width
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end
end
