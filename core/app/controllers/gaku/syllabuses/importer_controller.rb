# -*- encoding: utf-8 -*-
module Gaku
  class Syllabuses::ImporterController < GakuController

    skip_authorization_check

    def index
      #@importer_types = ["GAKU Engine"]
      render 'gaku/syllabuses/importer/index'
    end

    def get_template
    end

    def import_from_template
    end

  end
end
