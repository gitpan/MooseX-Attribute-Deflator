package MyTest;

use Moose;

use MooseX::Types::Moose qw(ArrayRef);
use MooseX::Types::Structured qw(Dict);
use MooseX::Types -declare => [qw(Person)];

subtype Person, as Dict [ friends => ArrayRef [Person] ];
