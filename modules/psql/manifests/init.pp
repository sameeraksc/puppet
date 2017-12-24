class psql (
  $timestamp = generate('/bin/date', '+%Y%m%d'),
 #$timestamp = 'sameera',
  $restorepath = '/rezsystem/uploads/dm/',
  #$database = xx , 
  #$port = xx ,
) 
{
  exec {'Dump oldDb':
    command => "/usr/local/pgsql/bin/pg_dump -f /home/uploads/DM_BK-${timestamp}/dm.sql --username=postgres --schema=dm  pgdev",
    path    => '/usr/local/pgsql/bin/',  
  }

  exec {'Restore database':
    command => "/usr/local/pgsql/bin/psql -U postgres --pset pager -f ${restorepath}dm.sql pgdev",
    path    => '/usr/local/pgsql/bin/',
    require => Exec ['Dump oldDb'] ,
  }
  file {"/home/uploads/DM_BK-${timestamp}":
    ensure => directory,
    owner => 'postgres',
    group => 'postgres',
    mode => '775',
    before => Exec['Dump oldDb']  
    
  }
  exec {'Extract Tar file':
    command => "cd ${restorepath} && tar xzf dm.sql.tar.gz",
    path    => ['/usr/bin','usr/sbin'],
    before  => Exec['Restore database'],
  }
}
