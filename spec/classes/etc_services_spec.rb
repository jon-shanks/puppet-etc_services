require "#{File.join(File.dirname(__FILE__),'..','/..','/..','/spec_helper.rb')}"

describe 'etc_services' do
  context 'with nothing seto' do  
    it { should contain_class('etc_services::package') }
  end

  context 'with config set' do
    let(:params) { {:config => {'service_test'=>{'name'=>'TEST123', 'port'=>'123456', 'protocol'=>'tcp', 'comment'=>'this test'}}} }

    it do 
      should contain_augeas('service_test').with({
        'incl'    => '/etc/services',
        'lens'    => 'Services.lns',
        'changes' => '["defnode svc service-name[port = \'123456\' and protocol = \'tcp\'] TEST123", "set $svc/port 123456", "set $svc/protocol tcp", "set $svc/#comment \'this test\'"]',
      })
    end
  end
end

