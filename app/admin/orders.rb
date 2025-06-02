# app/admin/orders.rb

ActiveAdmin.register Order do
  permit_params :first_name, :last_name, :middle_name, :phone, :email,
                :weight, :length, :width, :height, :from, :to,
                :distance, :price, :status

  index do
    selectable_column
    id_column
    column :user
    column :from
    column :to
    column :price
    column :distance
    column :status
    actions defaults: true do |order|
      if order.may_start_processing?
        item "В обработку", start_processing_admin_order_path(order), method: :put
      end
      if order.may_complete?
        item "Завершить", complete_admin_order_path(order), method: :put
      end
      if order.may_reject?
        item "Отклонить", reject_admin_order_path(order), method: :put
      end
    end
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :middle_name
      row :phone
      row :email
      row :weight
      row :length
      row :width
      row :height
      row :from
      row :to
      row :distance
      row :price
      row :created_at
    end
  end
  
  member_action :start_processing, method: :put do
    resource.start_processing!
    redirect_to resource_path, notice: "Заказ переведён в обработку"
  end

  member_action :complete, method: :put do
    resource.complete!
    redirect_to resource_path, notice: "Заказ завершён"
  end

  member_action :reject, method: :put do
    resource.reject!
    redirect_to resource_path, notice: "Заказ отклонён"
  end
end
