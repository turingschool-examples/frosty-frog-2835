require 'rails_helper'

RSpec.describe "Patient Index" do
  before do
    @hospital = Hospital.create!(name: "UC Health")

    @doctor_1 = @hospital.doctors.create!(name: "Roxy", specialty: "MRI", university: "MSU")
    @doctor_2 = @hospital.doctors.create!(name: "Jenna", specialty: "Liver", university: "CU Boulder")

    @patient_1 = @doctor_1.patients.create!(name: "Lance", age: 19)
    @doctor_2.patients << @patient_1
    @patient_2 = @doctor_1.patients.create!(name: "Shiba", age: 7)
    @patient_3 = @doctor_2.patients.create!(name: "Gojo", age: 23)
  end

  describe "User Story 3" do
    it "has all patients names of adult patient" do
      visit patients_path

      expect(page).to have_content("Lance")
      expect(page).to have_content("Gojo")
      expect(page).to_not have_content("Shiba")
    end
  end
end