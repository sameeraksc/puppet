# Class: scp
#
# This module manages scp
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class scp {
  scp {"/rezsystem/uploads/dm/dm.sql.tar.gz":
    ensure => present,
    source => "root@kanishkaos2:/rezsystem/uploads/dm/dm.sql.tar.gz",
    
      }           

}
