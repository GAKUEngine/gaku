module Gaku
  class NotesController < GakuController

    #load_and_authorize_resource :note, class: Gaku::Note

    before_action :set_notable
    before_action :set_note,    only: %i( edit update destroy )
    respond_to :js

    def new
      @note = Note.new
      respond_with @note
    end

    def create
      @note = @notable.notes.new(note_params)
      @note.save
      set_count
      respond_with @note
    end

    def edit
    end

    def show
    end

    def update
      @note.update(note_params)
      respond_with @note
    end

    def destroy
      @note.destroy
      set_count
      respond_with @note
    end

    private

    def note_params
      params.require(:note).permit(note_attr)
    end

    def note_attr
      %i(title content)
    end

    def notable_klasses
      [
        Gaku::Student,
        Gaku::Teacher,
        Gaku::LessonPlan,
        Gaku::Syllabus,
        Gaku::ClassGroup,
        Gaku::Course,
        Gaku::Exam
      ]
    end

    def set_count
      @count = @notable.reload.notes_count
    end

    def set_note
      @note = Note.find(params[:id])
    end

    def set_notable
      unnamespaced_klass = ''
      klass = notable_klasses.find do |c|
        unnamespaced_klass = c.to_s.split('::')
        params["#{unnamespaced_klass[1].underscore}_id"]
      end

      @notable = klass.find(params["#{unnamespaced_klass[1].underscore}_id"])
      @notable_resource = get_resource_name @notable
    end

  end
end
