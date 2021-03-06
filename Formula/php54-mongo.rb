require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Mongo < AbstractPhpExtension
  homepage 'http://pecl.php.net/package/mongo'
  url 'http://pecl.php.net/get/mongo-1.2.11.tgz'
  md5 '4a6e9d71ec266365c591284950d29167'
  head 'https://github.com/mongodb/mongo-php-driver.git'

  depends_on 'autoconf' => :build
  depends_on 'php54' if ARGV.include?('--with-homebrew-php') && !Formula.factory('php54').installed?

  def install
    Dir.chdir "mongo-#{version}" unless ARGV.build_head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    safe_phpize
    system "./configure", "--prefix=#{prefix}"
    system "make"
    prefix.install "modules/mongo.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
