module ManufacturingCompany
  attr_reader :company

  def add_company(company)
    @company = "Компания-производитель - #{company}"
  end
end
