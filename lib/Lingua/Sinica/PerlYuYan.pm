package Lingua::Sinica::PerlYuYan;

use 5.008;
use utf8;
use strict;
use Filter::Simple::Compile;
use Encode ();

our $VERSION = 1257340475; # 2009年11月 4日 周三 21時14分27秒 CST

=encoding utf8

=head1 NAME

Lingua::Sinica::PerlYuYan - Perl in Classical Chinese in Perl - 中書珨

=head1 VERSION

our $VERSION = 1257340475; # 2009年11月 4日 周三 21時14分27秒 CST

=head1 SYNOPSIS

    # The Sieve of Eratosthenes - 埃拉托斯芬篩法
    use Lingua::Sinica::PerlYuYan;

      用籌兮用嚴。井涸兮無礙
    。印曰最高矣  又道數然哉。
    。截起吾純風  賦小入大合。
    。習予吾陣地  並二至純風。
    。當起段賦取  加陣地合始。
    。陣地賦篩始  繫繫此雜段。
    。終陣地兮印  正道次標哉。
    。輸空接段點  列終註泰來。

=head1 DESCRIPTION

This module makes it possible to write Perl programs in Classical Chinese poetry in Perl.

說此經者，能以珨文言文珨。

(If one I<has> to ask "Why?", please refer to L<Lingua::Romana::Perligata> for
related information.)

(闕譯，以待來者。)

This module uses the single-character property of Chinese to disambiguate
between keywords, so one may elide whitespaces much like in real Chinese writings.

The vocabulary is in the 文言 (literary text) mode, not the common 白話
(spoken text) mode with multisyllabic words.

C<Lingua::Sinica::PerlYuYan::translate()> (or simply as C<譯()>) translates a
string containing English programs into Chinese.

=cut

our %Tab;
while (<DATA>) {
    $_ = Encode::is_utf8($_) ? $_ : Encode::decode_utf8($_);

    next if /^\s*$/;
    my @eng = split ' ';
    my @chi = map {/\A [!-~]+ \z/msx ? $_ : split //, $_}
      # clusters of ASCII are untranslated keywords; keep them
      split ' ', <DATA>;
    for (my $i = 0; $i <= $#eng; $i++) {
        next if $chi[$i] eq $eng[$i];    # filter untranslated
        $Tab{$chi[$i]} =    # append space if keyword, but not single letter
        $eng[$i] =~ /\A [a-z]{2,} \z/msx ? $eng[$i] . ' ' : $eng[$i];
    }
}

@Tab{qw{ 資曰     亂曰    檔曰     列曰     套曰        }}
   = qw{ __DATA__ __END__ __FILE__ __LINE__ __PACKAGE__ };

FILTER {
    $_ = Encode::is_utf8($_) ? $_ : Encode::decode_utf8($_);

    foreach my $key ( sort { length $b <=> length $a } keys %Tab ) {
        s/$key/$Tab{$key}/g;
    }

    return($_ = Encode::encode_utf8($_));
};

no warnings 'redefine';
sub translate {
    my $code = shift;

    for my $key (sort {length $Tab{$b} cmp length $Tab{$a}} keys %Tab) {
        $code =~ s/\Q$Tab{$key}\E/$key/g;
    }

    return $code;
}

1;

=head1 SEE ALSO

L<Filter::Simple::Compile>, L<Lingua::Romana::Perligata>

=head1 CC0 1.0 Universal

To the extent possible under law, 唐鳳 has waived all copyright and related
or neighboring rights to Lingua-Sinica-PerlYuYan.

This work is published from Taiwan.

L<http://creativecommons.org/publicdomain/zero/1.0>

=begin html

<p xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/" style="text-decoration:none;">
    <img src="http://i.creativecommons.org/l/zero/1.0/88x31.png" border="0" alt="CC0" />
  </a>
  <br />
  To the extent possible under law, <a href="http://www.audreyt.org/" rel="dct:publisher"><span property="dct:title">唐鳳</span></a>
  has waived all copyright and related or neighboring rights to
  <span property="dct:title">Lingua-Sinica-PerlYuYan</span>.
This work is published from
<span about="http://www.audreyt.org/" property="vcard:Country" datatype="dct:ISO3166" content="TW">Taiwan</span>.
</p>

=end html

=cut

__DATA__
a b c d e f g h i j k l m n o p q r s t u v w x y z
甲乙丙丁戊己庚辛壬癸子丑寅卯辰巳午未申酉戌亥地水火風
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
青心赤肝黃脾白肺黑腎鼠牛虎兔龍蛇馬羊猴雞狗豬春夏秋冬

0 1 2 3 4 5 6 7 8 9 10 100 1000 10000 10000_0000
零一二三四五六七八九十 百  千   萬    億
0 1 2 3 4 5 6 7 8 9 10 100 1000 20 30
零壹貳毿肆伍陸柒捌玖拾 佰  仟   廿 卅
0 1 2 3 4 5 6 7 8 9
０１２３４５６７８９

! @ # # $ % % ^ & * ( ) - = _ + + [ ] { } \ | ; : :
非陣井註純雜模析和乘起合減賦底加正內外始終參聯兮然標
' ' " " , , => < . . > / / ? ` ` ~
曰矣道哉又並與 小點接大除分歟行者繫
! @ # $ % ^ & * ( ) - = _ + [ ] { } \ | ; ; : ' " , , < . > / ? ` ~
！＠＃＄％︿＆＊（）－＝＿＋〔〕｛｝╲｜；。：’”，、＜．＞╱？‵～

.. ... ** ++ -- -> ::
至 乃  冪 增 扣 之 宗

&& == || and or lt gt cmp eq not
及 等 許 且  或 前 後 較  同 否

=~ !~ x <=> ne ~~ //
=~ !~ x <=> ne ~~ //

<< >> <= >= le ge != ne xor
<< >> <= >= le ge != ne xor

**= += *= &= <<= &&= -= /= |= >>= ||= .= %= ^= //= x=
**= += *= &= <<= &&= -= /= |= >>= ||= .= %= ^= //= x=

$/ $_ @_ "\x20" "\t" "\n" main
段 此 諸 空     格   列   主

STDIN STDOUT STDERR DATA BEGIN END INIT CHECK DESTROY
入    出     誤     料   創    末  育   察    滅

chomp chop chr crypt hex index lc lcfirst length oct ord pack q/ qq/ reverse
截    斬   文  密    爻  索    纖 細      長     卦  序  包   引 雙  逆
rindex sprintf substr tr/ uc ucfirst y/
檢     編      部     轉  壯 厚      換

m/ pos quotemeta s/ split study qr/
符 位  逸        代 切    習    規

abs atan2 cos exp hex int log oct rand sin sqrt srand
絕  角    餘  階  爻  整  對  卦  亂   弦  根   騷

pop push shift splice unshift
彈  推   取    抽     予

grep join map qw/ reverse sort unpack
篩   併   映  篇  逆      排   啟

delete each exists keys values
刪     每   存     鍵   值

binmode close closedir dbmclose dbmopen die eof fileno flock format getc
法      閉    關       閤       揭      死  結  號     鎖    排     擷
print printf read readdir rewinddir seek seekdir select syscall
印    輸     讀   覽      迴        搜   尋      擇     召
sysread sysseek syswrite tell telldir truncate warn write
鑑      狩      敕       告   訴      縮       訊   寫

pack read unpack vec
包   讀   啟     向

chdir chmod chown chroot fcntl glob ioctl link lstat mkdir open opendir
目    權    擁    遷     控    全   制    鏈   況    造    開   展
readlink rename rmdir stat symlink umask unlink utime
readlink 更     毀    態   symlink 蒙    鬆     刻

say if else elsif until while until foreach given when default break
say 倘 else elsif until 當 until foreach given when default break

caller continue die do dump eval exit goto last next redo return sub wantarray
喚     續       死  為 傾   執   離   躍   尾   次   重   回     副  欲

caller import local my our package use
喚     導     域    吾 咱  套      用

defined dump eval formline local my our reset scalar undef wantarray
定      傾   執   formline 域    吾 咱  抹    量     消    欲

alarm exec fork getpgrp getppid getpriority kill
鈴    生   殖   getpgrp getppid getpriority 殺

for
重

pipe qx/ setpgrp setpriority sleep system times wait waitpid
管   qx/ setpgrp setpriority 眠    作     計    候   waitpid

do no package require use
為 無 套      必      用

bless dbmclose dbmopen package ref tie tied untie
祝    dbmclose dbmopen 套      照  纏  縛   解

accept bind connect getpeername getsockname getsockopt listen recv send
受     束   連      getpeername getsockname getsockopt 聆     收   送

setsockopt shutdown sockatmark socket socketpair
setsockopt shutdown sockatmark 槽     socketpair

msgctl msgget msgrcv msgsnd semctl semget semop shmctl shmget shmread shmwrite
msgctl msgget msgrcv msgsnd semctl semget semop shmctl shmget shmread shmwrite

endgrent endhostent endnetent endpwent getgrent getgrgid getgrnam
endgrent endhostent endnetent endpwent getgrent getgrgid getgrnam

getlogin getpwent getpwnam getpwuid setgrent setpwent
getlogin getpwent getpwnam getpwuid setgrent setpwent

endprotoent endservent gethostbyaddr gethostbyname
endprotoent endservent gethostbyaddr gethostbyname

gethostent getnetbyaddr getnetbyname getnetent
gethostent getnetbyaddr getnetbyname getnetent

getprotobyname getprotobynumber getprotoent
getprotobyname getprotobynumber getprotoent

getservbyname getservbyport getservent sethostent
getservbyname getservbyport getservent sethostent

setnetent setprotoent setservent
setnetent setprotoent setservent

gmtime localtime time
準     區        時

attributes autouse base blib bytes charnames constant diagnostics encoding fields
性         活      基   括   字    名        常       診          碼       欄
filetest integer less locale overload sigtrap strict subs utf8 vars vmsish warnings
試       籌      少   國     載       號      嚴     式   通   變   倭     警
Lingua::Sinica::PerlYuYan::translate Lingua::Sinica::PerlYuYan::Tab
譯                                   表
