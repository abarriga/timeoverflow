ActiveAdmin.register Category do

  index do
    selectable_column
    id_column
    column :name, sortable: false
    default_actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
    end
    f.actions
  end

  show(title: :name) do |cat|
    attributes_table do
      row :created_at
      row :updated_at
      row :name_translations do
        cat.disable_fallback
        content_tag :dl do
          I18n.available_locales.map do |loc|
            next unless cat.send("name_#{loc}")
            content_tag(:dt, loc) +
            content_tag(:dd, cat.send("name_#{loc}"))
          end.compact.sum
        end
      end
    end
    active_admin_comments
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

end
