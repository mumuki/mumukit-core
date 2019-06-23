describe Object do
  describe '#as_module' do
    it { expect('Integer'.as_module_name).to eq 'Integer' }
    it { expect(:Integer.as_module_name).to eq 'Integer' }
    it { expect(:integer.as_module_name).to eq 'Integer' }
    it { expect(Integer.as_module_name).to eq 'Integer' }

    it { expect('Integer'.as_variable_name).to eq 'integer' }
    it { expect(:Integer.as_variable_name).to eq 'integer' }
    it { expect(:integer.as_variable_name).to eq 'integer' }
    it { expect(Integer.as_variable_name).to eq 'integer' }

    it { expect('Integer'.as_module).to eq Integer }
    it { expect(:Integer.as_module).to eq Integer }
    it { expect(:integer.as_module).to eq Integer }
    it { expect(Integer.as_module).to eq Integer }

    it { expect('PatchAdams'.as_module).to eq PatchAdams }
    it { expect('patch_adams'.as_module).to eq PatchAdams }
    it { expect('patch_adams/configurable'.as_module).to eq PatchAdams::Configurable }
    it { expect(PatchAdams.as_module).to eq PatchAdams }
  end
end
