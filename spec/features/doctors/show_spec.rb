require 'rails_helper'

RSpec.describe "Doctor show" do
  before do
    @hospital = Hospital.create!(name: "UC Health")

    @doctor_1 = @hospital.doctors.create!(name: "Roxy", specialty: "MRI", university: "MSU")
    @doctor_2 = @hospital.doctors.create!(name: "Jenna", specialty: "Liver", university: "CU Boulder")
  end

  it "list a doctor and their attributes" do
    visit doctor_path(@doctor_1)

    expect(page).to have_content("Roxy")
    expect(page).to have_content("MRI")
    expect(page).to have_content("MSU")

    expect(page).to_not have_content("Jenna")
    expect(page).to_not have_content("Liver")
    expect(page).to_not have_content("CU Boulder")
  end
end