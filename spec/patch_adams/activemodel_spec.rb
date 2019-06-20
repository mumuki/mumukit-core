require_relative '../spec_helper'

describe ActiveModel::Naming do
  module Sample
    class MyModel
      extend ActiveModel::Naming

      demodulized_model_name
    end
  end

  class MyOtherModel
    extend ActiveModel::Naming

    name_model_as Sample::MyModel
  end

  describe '#demodulized_model_name' do
    it { expect(Sample::MyModel.model_name.to_s).to eq 'MyModel' }
    it { expect(Sample::MyModel.new.model_name.to_s).to eq 'MyModel' }
  end

  describe '#name_model_as' do
    it { expect(MyOtherModel.model_name).to eq Sample::MyModel.model_name }
    it { expect(MyOtherModel.new.model_name).to eq Sample::MyModel.model_name }
  end
end
