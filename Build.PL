
use strict;
use warnings;

use Module::Build 0.3601;

my %module_build_args = (
                       'dist_abstract' => 'Deflates and inflates Moose attributes to and from a string',
                       'script_files' => [],
                       'license' => 'bsd',
                       'build_requires' => {
                                             'DateTime' => '0',
                                             'MooseX::Types::Moose' => '0',
                                             'Scalar::Util' => '0',
                                             'Test::Exception' => '0',
                                             'English' => '0',
                                             'MooseX::Types::Structured' => '0',
                                             'Carp' => '0',
                                             'Test::More' => '0.88',
                                             'perl' => '5.004',
                                             'MooseX::Types' => '0',
                                             'File::Find' => '0',
                                             'File::Temp' => '0',
                                             'Module::Build' => '0.3601'
                                           },
                       'dist_name' => 'MooseX-Attribute-Deflator',
                       'dist_author' => [
                                          'Moritz Onken'
                                        ],
                       'module_name' => 'MooseX::Attribute::Deflator',
                       'requires' => {
                                       'Moose::Util' => '0',
                                       'Moose::Role' => '0',
                                       'JSON' => '0',
                                       'Moose::Exporter' => '0',
                                       'Moose' => '1.01'
                                     },
                       'recommends' => {},
                       'configure_requires' => {
                                                 'Module::Build' => '0.3601'
                                               },
                       'dist_version' => '1.100990'
                     );


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
