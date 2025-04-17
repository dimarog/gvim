#!/usr/local/bin/perl -w

###############################################################################################################################################
# This file is a "filter", designed to run on cn_lint's output and convert all messages to a common format, parsable by VIM's compiler syntax
###############################################################################################################################################

$| = 1; #disable buffering; otherwise, output from cn_lint doesn't appear in VIM until the very end

my $project_dir = `project_dir --project`;
chomp $project_dir;

my $multiline = 0;
my $found = 0;

while (<>) {

    #  ERR  [#59034] : on line 228 in file project/rtl/ilk/ilk_rlk_bic.v
    #                : 'RXRSP_FIFO_WIDTH' is not declared 
    if ($multiline) {
        $multiline = 0;
        /: (.*)/;
        print "$1\n";
        $found = 1;
    } 
    elsif (/\s+(\S).*: on line (\d+) in file (.*)/) {
        my $err  = $1;
        my $line = $2;
        my $file = $3; 
        $file =~ s/^project/$project_dir/; #in both svn and git, file starts with "project/" for this error type
        print "%$err- $file:$line:"; #no new line
        $multiline = 1;
    }

    #%W-   INIT_ASSIGN[Pick Best: CN_INITIAL_BLK,CN_BEH,CN_COVERAGE,CN_NO_SYNTH]:   out_event_buffer.v:104   Initial value ... ignored for logic synthesis [rtl/.../out_event_buffer.v]  
    elsif (/%(\S)-\s+(\S.*\]):\s+([^:]+):(\d+)\s+(.*)\[(.*)\]/) {
        my $err  = $1;
        my $msg1 = $2;
        my $line = $4;
        my $msg2 = $5;
        my $file = $6; 
        $file = $project_dir."/".$file unless ($file =~ /^\//); #in svn, file is relative to project/; in git, it's a full path name
        print "%$err- $file:$line:$msg1: $msg2\n";
        $found = 1;
    }

    #%E-   INPUT_ASSIGN:   out_event_buffer.v:104   Assignment to input 'csr_cr0_eventqen' encountered [rtl/.../out_event_buffer.v]
    #%E- PORT_BITLEN: rpm_mtip_mem.v:542 Mismatch between 'pcs000_f91ro_raddr[4 * 0 +: 4]' length 4 and port 'f91ro[0].U_F91RO_RAM.aa' length 5 declared in module 'rpm_mti_mac_tx_stat_mem' at rpm_mti_mac_tx_stat_mem.v:57 [/nfs/rgdv/eliyab/active5_roc_net_rpm/eg_ip/blocks/rpm/rtl__rpm/master/rpm_mtip_mem.v]
    elsif (/%(\S)-\s+(\S.+?):\s+([^:]+):(\d+)\s+(.*)\[(.*)\]/) {
        #print "DEBUG 1: $1, 2:$2, 3:$3, 4:$4, 5:$5, 6:$6\n";
        my $err  = $1;
        my $msg1 = $2;
        my $line = $4;
        my $msg2 = $5;
        my $file = $6; 
        $file = $project_dir."/".$file unless ($file =~ /^\//); #in svn, file is relative to project/; in git, it's a full path name
        print "%$err- $file:$line:$msg1: $msg2\n";
        $found = 1;
    }

    #halcheck: *W,CUSTOM[CN_INCLUDE_SCOPE] (out_event_buffer.v,22): Included file "chip_params.vh" should be included at the module scope - found at the global scope.
    elsif (/halcheck: \*(\S),(\S+)\s+\(\.\/(.+),(\d+)\):\s+(.*)/) {
        my $err  = $1;
        my $msg1 = $2;
        my $file = $3; #file name seems to start with an additional "./" in this msg (?!)
        my $line = $4;
        my $msg2 = $5;
        $file = $project_dir."/".$file unless ($file =~ /^\//); #in svn, file is relative to project/ (??? need to check); in git, it's a full path name
        print "%$err- $file:$line:$msg1: $msg2\n";
        $found = 1;
    }

    #%Error: project/rtl/ocx/ocx_rlk_dat.v:67: syntax error, unexpected ::, expecting ';'
    # Error: out_event_buffer.v:683: do not use native rule VALID_COMPARE.  Fix or request a new CN_ pragma rule instead
    #Error: out_event_buffer.v:234: Unrecognized cn_lint pragma: cn_lint_o
    elsif (/Error: ([^:]+):(\d+):\s+(.*)/) {
        my $file = $1; 
        my $line = $2;
        my $msg  = $3;
        $file =~ s/^project/$project_dir/; #in svn, file starts with "project/";  in git, it's a full path name
        print "%E- $file:$line:$msg\n";
        $found = 1;
    }

    #when running on a file outside the project dir:
    #YAML Error: Couldn't open %Error:_Project_not_set/dvconf/dvconf.yaml for input:\nNo such file or directory
    elsif (/YAML Error: Couldn't open/) {
        print "%E- __NO_FILE__:1:$_\n";
        $found = 1;
    }

    #%F- Lint Failure: 10x_soc/cn_lint/.hal.rg1user04.18031/irun.log not found
    elsif (/%F- Lint Failure/) {
        print "%E- __NO_FILE__:1:$_\n" unless $found; # show this only if no other errors were found, since it's not very informative
    }

    #ERROR (project/rtl/rpm/rpm_cmr.v) Rule CN_UNUSED_IN is disabled on line 128 and is not enabled
    elsif (/^ERROR \((.*)\) (Rule.*is disabled on line )(\d+)(.*)/) {
        my $file = $1; 
        my $line = $3;
        my $msg  = $2.$3.$4;
        $file =~ s/^project/$project_dir/; #for this error type, file starts with "project/"
        print "%E- $file:$line:$msg\n";
        $found = 1;
    }

    #a last resort - if we missed some error message
    elsif (/NOT LINT clean/) {
        print "%E- __NO_FILE__:1:Unknown cn_lint error - run it from a shell!\n" unless $found; # show this only if no other errors were found, since it's not very informative
    }

    else {
        print "$_"; 
    }
};
