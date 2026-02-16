#!/usr/bin/perl
use strict;
use warnings;

use Win32::GUI();

# --- Main window ---
my $W = Win32::GUI::Window->new(
    -name   => 'Main',
    -text   => 'Win32::GUI - Mini Calculator (Demo)',
    -width  => 260,
    -height => 340,
);

# --- Display box ---
my $Display = $W->AddTextfield(
    -name     => 'Display',
    -left     => 10,
    -top      => 10,
    -width    => 220,
    -height   => 28,
    -readonly => 1,
    -text     => '0',
);

# Helper to add a button
sub add_btn {
    my (%o) = @_;
    return $W->AddButton(
        -name   => $o{name},
        -text   => $o{text},
        -left   => $o{left},
        -top    => $o{top},
        -width  => $o{width}  // 50,
        -height => $o{height} // 40,
    );
}

# --- Buttons layout ---
my $x0 = 10;
my $y0 = 55;
my $w  = 50;
my $h  = 40;
my $g  = 5;

# Row 1
add_btn(name => 'BtnC',   text => 'C',   left => $x0 + 0*($w+$g), top => $y0 + 0*($h+$g));
add_btn(name => 'BtnDiv', text => '/',   left => $x0 + 1*($w+$g), top => $y0 + 0*($h+$g));
add_btn(name => 'BtnMul', text => '*',   left => $x0 + 2*($w+$g), top => $y0 + 0*($h+$g));
add_btn(name => 'BtnBk',  text => '⌫',   left => $x0 + 3*($w+$g), top => $y0 + 0*($h+$g));

# Row 2
add_btn(name => 'Btn7', text => '7', left => $x0 + 0*($w+$g), top => $y0 + 1*($h+$g));
add_btn(name => 'Btn8', text => '8', left => $x0 + 1*($w+$g), top => $y0 + 1*($h+$g));
add_btn(name => 'Btn9', text => '9', left => $x0 + 2*($w+$g), top => $y0 + 1*($h+$g));
add_btn(name => 'BtnSub', text => '-', left => $x0 + 3*($w+$g), top => $y0 + 1*($h+$g));

# Row 3
add_btn(name => 'Btn4', text => '4', left => $x0 + 0*($w+$g), top => $y0 + 2*($h+$g));
add_btn(name => 'Btn5', text => '5', left => $x0 + 1*($w+$g), top => $y0 + 2*($h+$g));
add_btn(name => 'Btn6', text => '6', left => $x0 + 2*($w+$g), top => $y0 + 2*($h+$g));
add_btn(name => 'BtnAdd', text => '+', left => $x0 + 3*($w+$g), top => $y0 + 2*($h+$g));

# Row 4
add_btn(name => 'Btn1', text => '1', left => $x0 + 0*($w+$g), top => $y0 + 3*($h+$g));
add_btn(name => 'Btn2', text => '2', left => $x0 + 1*($w+$g), top => $y0 + 3*($h+$g));
add_btn(name => 'Btn3', text => '3', left => $x0 + 2*($w+$g), top => $y0 + 3*($h+$g));
add_btn(name => 'BtnEq', text => '=', left => $x0 + 3*($w+$g), top => $y0 + 3*($h+$g), height => $h*2 + $g);

# Row 5
add_btn(name => 'Btn0', text => '0', left => $x0 + 0*($w+$g), top => $y0 + 4*($h+$g), width => $w*2 + $g);
add_btn(name => 'BtnDot', text => '.', left => $x0 + 2*($w+$g), top => $y0 + 4*($h+$g));

# --- Minimal behavior (just shows it works) ---
# Click digits/operators -> append to display; C clears; Backspace deletes; '=' just shows "Demo".
my $expr = '';

sub set_display {
    my ($s) = @_;
    $Display->Text($s eq '' ? '0' : $s);
}

sub append {
    my ($t) = @_;
    $expr .= $t;
    set_display($expr);
}

sub clear_all {
    $expr = '';
    set_display($expr);
}

sub backspace {
    $expr = substr($expr, 0, length($expr) - 1) if length $expr;
    set_display($expr);
}

# Provide button handlers expected by Win32::GUI:
sub Main_Terminate { return -1; }  # close window
sub Main_BtnC_Click   { clear_all(); 1 }
sub Main_BtnBk_Click  { backspace(); 1 }
sub Main_BtnEq_Click  { set_display("Demo (no eval)"); $expr = ''; 1 }

# Digits
sub Main_Btn0_Click { append('0'); 1 }
sub Main_Btn1_Click { append('1'); 1 }
sub Main_Btn2_Click { append('2'); 1 }
sub Main_Btn3_Click { append('3'); 1 }
sub Main_Btn4_Click { append('4'); 1 }
sub Main_Btn5_Click { append('5'); 1 }
sub Main_Btn6_Click { append('6'); 1 }
sub Main_Btn7_Click { append('7'); 1 }
sub Main_Btn8_Click { append('8'); 1 }
sub Main_Btn9_Click { append('9'); 1 }

# Ops
sub Main_BtnAdd_Click { append('+'); 1 }
sub Main_BtnSub_Click { append('-'); 1 }
sub Main_BtnMul_Click { append('*'); 1 }
sub Main_BtnDiv_Click { append('/'); 1 }
sub Main_BtnDot_Click { append('.'); 1 }

# --- Show and run message loop ---
$W->Show();
Win32::GUI::Dialog();
