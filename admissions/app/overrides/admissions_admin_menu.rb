Deface::Override.new(:virtual_path => "gaku/shared/menu/_admin",
                     :name => "admissions_admin_menu",
                     :insert_before => "[data-hook='types_sub_menu']",
                     :partial => "gaku/shared/menu/admissions_sub_menu")