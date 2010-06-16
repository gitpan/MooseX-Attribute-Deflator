
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Carp' => '0',
    'DateTime' => '0',
    'English' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Module::Build' => '0.3601',
    'MooseX::Types' => '0',
    'MooseX::Types::Moose' => '0',
    'MooseX::Types::Structured' => '0',
    'Scalar::Util' => '0',
    'Test::Exception' => '0',
    'Test::More' => '0.94',
    'perl' => '5.004'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Deflates and inflates Moose attributes to and from a string',
  'dist_author' => [
    'Moritz Onken'
  ],
  'dist_name' => 'MooseX-Attribute-Deflator',
  'dist_version' => '1.101670',
  'license' => 'bsd',
  'module_name' => 'MooseX::Attribute::Deflator',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'JSON' => '0',
    'Moose' => '1.01',
    'Moose::Exporter' => '0',
    'Moose::Meta::Method::Accessor' => '0',
    'Moose::Role' => '0',
    'Moose::Util' => '0'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
