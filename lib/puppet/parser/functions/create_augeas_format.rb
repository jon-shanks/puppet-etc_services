module Puppet::Parser::Functions
  newfunction(:create_augeas_format, :type => :rvalue, :doc => <<-ENDHEREDOC
    Creates the Augeas layout specific to etc_services only, this could be expanded on
    later on but as each lens has its own custom defined structure, it would need
    a separate provider / type for each defined type. 

    It will take a hash of name, port, protocol, comment and create a new entry for it
    in the augeas format to set the new etc_services setup, to then be used by
    create_resources.

    Example:

      $config = {'service1'=>{'name'     => 'UDP_MATCHING',
                              'port'     => '123456789',
                              'protocol' => 'tcp',
                              'comment'  => 'This is the matchign engine'}}
      $augeas_structure = create_augeas_format($config)

    ENDHEREDOC
   ) do |args|

    if args.length != 1
      raise Puppet::ParseError, "create_augeas_format(): wrong number of arguments, given (#{args.length} for 1)"
    end

    accumulator = Hash.new
    args.each do |arg|
      unless arg.is_a?(Hash)
        raise Puppet::ParseError, "create_augeas_format: unexpected argument, expected hash"
      end
      arg.each_pair do |k,v|
        unless v.is_a?(Hash)
          raise Puppet::ParseError, "create_augeas_format: unexpected format, expected nested hash"
        end
        accumulator[k] = {'context' => '/files/etc/services',
                          'lens'    => 'Services.lns',
                          'incl'    => '/etc/services',
                          'changes' => ["defnode svc service-name[port = '#{v['port']}' and protocol = '#{v['protocol']}'] #{v['name']}",
                                        "set \$svc/port #{v['port']}",
                                        "set \$svc/protocol #{v['protocol']}",
                                        "set \$svc/#comment '#{v['comment']}'"]}
      end
    end
    accumulator
  end
end
