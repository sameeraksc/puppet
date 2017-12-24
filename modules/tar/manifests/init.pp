
class tar {
  $timestamp = generate('/bin/date','+%Y-%m-%d') 
  $dmpath    = "/home/uploads/schema_backup/monthly_dm_process/dm_backup/${timestamp}"
  $database  = 'pgdev'  

  exec {'Dump New DB':
    command => "pg_dump --file /home/uploads/schema_backup/monthly_dm_process/dm_backup/dm.sql --username=postgres --schema=dm ${database}",
    path    => '/usr/local/pgsql/bin/',
    before  => Exec['Tar SQL file'],
       }

#  exec {'Dump New DB':
#    command => "pg_dump --file /home/uploads/schema_backup/monthly_dm_process/dm_backup/dm.sql --username=postgres --schema=dm pgdev ",
#    path    => '/usr/local/pgsql/bin/',
#    before  => Exec['Tar SQL file'],
#       }

  exec {'Tar SQL file':
    command => "cd ${dmpath} && tar czf dm.sql.tar.gz dm.sql",
    path    => ['/usr/bin','/usr/sbin/'],
      }

 # exec {'Delete Old Dump':
 #   command => "cd ${dmpath} && rm -rf * ",
 #   path    => ['/usr/bin','/usr/sbin'],
 #   before  => Exec['Dump New DB'],
 #     }
  file {"/home/uploads/schema_backup/monthly_dm_process/dm_backup/${timestamp}":
    ensure => directory,
    owner => 'postgres',
    group => 'postgres',
    mode  => '775',
    before => Exec['Dump New DB'],
       }

}
