class useradd{
  user{'postgres':
    ensure  => 'present',
    comment => 'DB user',
    shell   => '/bin/bash',
    home    => '/home/postgres',
}
}
