module Gaku
	module StudentsHelper


    def surname_reading_label
      t(:phonetic_reading) + ' ('+t(:surname)+')'
    end

    def name_reading_label
      t(:phonetic_reading) + ' ('+t(:name)+')'
    end

    def surname_label
      t(:name)+' ('+t(:surname)+')'
    end

    def name_label
      t(:name)+' ('+t(:name)+')'
    end

    def address_icon
      content_tag :span, nil, class: 'glyphicon glyphicon-globe'
    end

    def contact_icon
      content_tag :span, nil, class: 'glyphicon glyphicon-envelope'
    end

    def guardian_icon
      content_tag :span, nil, class: 'glyphicon glyphicon-user'
    end

    def edit_button
      content_tag :span, nil, class: 'glyphicon glyphicon-pencil'
    end

    def ok_icon
      content_tag :span, nil, class: 'glyphicon glyphicon-ok'
    end

  end
end
