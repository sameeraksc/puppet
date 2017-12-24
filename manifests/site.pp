node default { }
#135 server
node kanishkaos2 {
   #135 server 
  #class { 'scp': }
  class { 'tar': }  

}
#destination servers
node kanishkaos3{
  class {'scp':}-> 
  class {'psql':}
}
