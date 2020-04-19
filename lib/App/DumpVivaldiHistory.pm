package App::DumpVivaldiHistory;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

our %SPEC;

$SPEC{dump_vivaldi_history} = {
    v => 1.1,
    summary => 'Dump Vivaldi history',
    args => {
        detail => {
            schema => 'bool*',
            cmdline_aliases => {l=>{}},
        },
        profiles => {
            summary => 'Select profile(s) to dump',
            schema => ['array*', of=>'vivaldi::profile_name*', 'x.perl.coerce_rules'=>['From_str::comma_sep']],
            description => <<'_',

You can choose to dump history for only some profiles. By default, if this
option is not specified, history from all profiles will be dumped.

_
        },
        copy_size_limit => {
            schema => 'posint*',
            default => 100*1024*1024,
            description => <<'_',

Vivaldi often locks the History database for a long time. If the size of the
database is not too large (determine by checking against this limit), then the
script will copy the file to a temporary file and extract the data from the
copied database.

_
        },
    },
};
sub dump_vivaldi_history {
    require App::DumpChromeHistory;

    App::DumpChromeHistory::dump_chrome_history(
        _app => 'vivaldi',
        _chrome_dir => "$ENV{HOME}/.config/vivaldi",
    );
}

1;
# ABSTRACT:

=head1 SYNOPSIS

See the included script L<dump-vivaldi-history>.


=head1 SEE ALSO

L<App::DumpChromeHistory>

L<App::DumpFirefoxHistory>

L<App::DumpOperaHistory>
