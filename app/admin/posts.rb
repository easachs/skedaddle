# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :title, :city, :country, :content, :published

  index do
    selectable_column
    id_column
    column :city
    column :country
    column :title
    column :published
    column 'Created', :created_at do |record|
      record.created_at.strftime('%m/%d/%y')
    end
    column 'Updated', :updated_at do |record|
      record.updated_at.strftime('%m/%d/%y')
    end
    actions
  end

  filter :city
  filter :title
  filter :published
  filter :created_at

  form do |f|
    f.inputs 'Post Details' do
      f.input :city
      f.input :country, as: :string
      f.input :title
      f.input :content
      f.input :published
    end
    f.actions
  end

  show do
    attributes_table do
      row :city
      row :country
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
