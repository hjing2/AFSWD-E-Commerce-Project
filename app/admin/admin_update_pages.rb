ActiveAdmin.register AdminUpdatePage do

  permit_params :title, :content

  form do |f|
    f.inputs 'Page Details' do
      f.input :title, as: :select, collection: ['Contact', 'About'], include_blank: false
      f.input :content, as: :text
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :content
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
