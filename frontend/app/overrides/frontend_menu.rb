Deface::Override.new(:virtual_path => "gaku/shared/menu/_global",
                     :name => "frontend_menu",
                     :insert_top => "[data-hook='menu']",
                     :partial => "gaku/shared/menu/frontend",
                     :disabled => false
                     )