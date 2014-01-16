Deface::Override.new(:virtual_path => "gaku/shared/menu/_global",
                     :name => "admin_menu",
                     :insert_bottom => "[data-hook='menu']",
                     :partial => "gaku/shared/menu/admin",
                     :disabled => false
                     )