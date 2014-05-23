require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'create_augeas_format' do
  context 'should pass hash or error' do
    it { should run.with_params('a','b').and_raise_error(Puppet::ParseError) }
    it { should run.with_params(['a','b']).and_raise_error(Puppet::ParseError) }
    it { should run.with_params(['a']).and_raise_error(Puppet::ParseError) }
  end


  context 'should run with hash and not error' do
    it { should run.with_params({'test123'=>{'name'=>'service_new'}}) }
  end

  context 'should run and return hash' do
    it 'should run' do
      subject.call([{'test123'=>{'name'=>'service_new'}}]).should be_an Hash
    end
  end
end
