class Gaku::Api::GuardianCreateService
  prepend SimpleCommand
  attr_accessor :guardian_params

  def initialize(guardian_params)
    @guardian_params = guardian_params
    @guardian = nil
  end

  def call
    contact =  guardian_params.delete(:contact)

    if contact
      @guardian = Gaku::Guardian.joins(:contacts).where(gaku_contacts: {data: contact}).find_by(required_attributes)
    end

    @guardian ||= create_guardian

    if @guardian.persisted?
      return @guardian
    else
      errors.add(:base, @guardian.errors.full_messages)
    end

  end

  def create_guardian
    Gaku::Guardian.create(guardian_params.except(:contact))
  end

  def required_attributes
    {
      name: guardian_params[:name],
      surname: guardian_params[:surname],
    }
  end
end
