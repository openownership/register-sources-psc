require 'register_sources_psc/structs/date_of_birth'

RSpec.describe RegisterSourcesPsc::DateOfBirth do
  let(:valid_date_of_birth) do
    { day: 6, month: 7, year: 1990 }
  end

  it 'allows date of birth' do
    date_of_birth = described_class[valid_date_of_birth]

    expect(date_of_birth.day).to eq 6
    expect(date_of_birth.month).to eq 7
    expect(date_of_birth.year).to eq 1990
  end

  context 'when date of birth has no day' do
    let(:valid_date_of_birth) do
      { month: 7, year: 1990 }
    end

    it 'allows date of birth' do
      date_of_birth = described_class[valid_date_of_birth]

      expect(date_of_birth.day).to be_nil
      expect(date_of_birth.month).to eq 7
      expect(date_of_birth.year).to eq 1990
    end
  end
end
