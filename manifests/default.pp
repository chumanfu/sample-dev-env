exec { "apt-update":
  path => '/usr/bin',
  command => 'sudo apt-get update'
}
package { "apache2":
  ensure  => present,
  require => Exec["apt-update"],
}
service { "apache2":
  ensure  => "running",
  require => Package["apache2"],
}
file { "/var/www/html/sample-webapp":
  ensure  => "link",
  target  => "/vagrant/sample-webapp",
  require => Package["apache2"],
  notify  => Service["apache2"],
}
