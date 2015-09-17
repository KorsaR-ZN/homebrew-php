require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Gearman < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/gearman'
  url 'http://pecl.php.net/get/gearman-1.1.2.tgz'
  sha256 'c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965'
  head 'https://svn.php.net/repository/pecl/gearman/trunk/'

  depends_on 'gearman'

  def install
    Dir.chdir "gearman-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula['gearman'].opt_prefix}"
    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
