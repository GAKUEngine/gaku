Deface::Override.new(virtual_path: 'gaku/shared/menu/_admin',
                     name: 'archive_menu',
                     insert_bottom: "[data-hook='admin_dropdown_menu']",
                     partial: 'gaku/shared/menu/archive',
                     disabled: false
                     )
