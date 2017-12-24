node default {
       file { '/etc/motd:
            owner => 'root',
            group => 'root',
            mode => '0644';
            content => "kanna"


 }

}


