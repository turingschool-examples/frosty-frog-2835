require 'rails_helper'

RSpec.describe "Doctor show" do
  before do
    @hospital = Hospital.create!(name: "UC Health")

    @doctor_1 = @hospital.doctors.create!(name: "Roxy", specialty: "MRI", university: "MSU")
    @doctor_2 = @hospital.doctors.create!(name: "Jenna", specialty: "Liver", university: "CU Boulder")

    @patient_1 = @doctor_1.patients.create!(name: "Lance", age: 19)
    @doctor_2.patients << @patient_1
    @patient_2 = @doctor_1.patients.create!(name: "Shiba", age: 7)
    @patient_3 = @doctor_2.patients.create!(name: "Gojo", age: 23)
  end

  describe "User Story 1" do
    it "list a doctor and their attributes" do
      visit doctor_path(@doctor_1)

      expect(page).to have_content("Roxy")
      expect(page).to have_content("MRI")
      expect(page).to have_content("MSU")

      expect(page).to_not have_content("Jenna")
      expect(page).to_not have_content("Liver")
      expect(page).to_not have_content("CU Boulder")
    end

    it "displays doctors hospital and patients" do
      visit doctor_path(@doctor_1)

      expect(page).to have_content("UC Health")

      expect(page).to have_content("Lance")
      expect(page).to have_content("Shiba")
      expect(page).to_not have_content("Gojo")
    end
  end

  describe "User Story 2" do
    it "has a button to delete/remove patent from doctor" do
      visit doctor_path(@doctor_1)
      
      within "#patient-#{@patient_1.id}" do
        expect(page).to have_content("Lance")
        expect(page).to have_button("remove")
        click_on "remove"
        
        expect(current_path).to eq(doctor_path(@doctor_1))
      end
      expect(page).to_not have_content("Lance")
      
      visit doctor_path(@doctor_2)
      expect(page).to have_content("Lance")
    end
  end
end