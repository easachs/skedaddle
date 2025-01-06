# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :title, :city, :content, :published

  index do
    selectable_column
    id_column
    column :city
    column :title
    column :published
    column :created_at
    column :updated_at
    actions
  end

  filter :city
  filter :title
  filter :published
  filter :created_at

  form do |f|
    f.inputs 'Post Details' do
      f.input :city
      f.input :title
      f.input :content
      f.input :published
    end
    f.actions
  end

  show do
    attributes_table do
      row :city
      row :title
      row :content do |post|
        post.content&.html_safe
      end
      row :published
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
