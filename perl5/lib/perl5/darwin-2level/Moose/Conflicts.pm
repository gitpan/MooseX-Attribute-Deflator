#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package # hide from PAUSE
    Moose::Conflicts;

use strict;
use warnings;

use Dist::CheckConflicts
    -dist      => 'Moose',
    -conflicts => {
        'Catalyst' => '5.80028',
        'Devel::REPL' => '1.003008',
        'Fey' => '0.36',
        'Fey::ORM' => '0.34',
        'File::ChangeNotify' => '0.15',
        'KiokuDB' => '0.49',
        'Markdent' => '0.16',
        'MooseX::Aliases' => '0.07',
        'MooseX::AlwaysCoerce' => '0.05',
        'MooseX::Attribute::Deflator' => '1.130000',
        'MooseX::Attribute::Dependent' => '1.0.0',
        'MooseX::Attribute::Prototype' => '0.10',
        'MooseX::AttributeHelpers' => '0.22',
        'MooseX::AttributeInflate' => '0.02',
        'MooseX::ClassAttribute' => '0.17',
        'MooseX::FollowPBP' => '0.02',
        'MooseX::HasDefaults' => '0.02',
        'MooseX::InstanceTracking' => '0.04',
        'MooseX::LazyRequire' => '0.05',
        'MooseX::MethodAttributes' => '0.22',
        'MooseX::NonMoose' => '0.15',
        'MooseX::POE' => '0.205',
        'MooseX::Params::Validate' => '0.05',
        'MooseX::Role::Cmd' => '0.06',
        'MooseX::Role::WithOverloading' => '0.07',
        'MooseX::SemiAffordanceAccessor' => '0.05',
        'MooseX::Singleton' => '0.24',
        'MooseX::StrictConstructor' => '0.08',
        'MooseX::Types' => '0.19',
        'MooseX::UndefTolerant' => '0.04',
        'Pod::Elemental' => '0.093280',
        'namespace::autoclean' => '0.08',
    },
    -also => [ qw(
        Data::OptList
        Devel::GlobalDestruction
        Eval::Closure
        List::MoreUtils
        MRO::Compat
        Package::DeprecationManager
        Package::Stash
        Package::Stash::XS
        Params::Util
        Scalar::Util
        Sub::Exporter
        Sub::Name
        Task::Weaken
        Try::Tiny
    ) ],

;

1;
