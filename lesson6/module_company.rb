module CompanyCreator

  attr_reader :company

  def assign_company(company)
    @company = company
  end

  protected

  attr_writer :company
end